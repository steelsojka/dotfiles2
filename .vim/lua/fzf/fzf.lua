local Subscription = require 'utils/subscription'
local Funcref = require 'utils/funcref'
local nvim = require 'nvim'
local unique_id = require 'utils/unique_id'
local utils = require 'utils/utils'

local Fzf = {}

-- Creates an FZF executor for running FZF in lua
-- @param sink Function to execute with selected line(s)
-- @param handle_all Whether to handle all lines or call the sink for each line
function Fzf:create(sink, handle_all)
  local instance = {}

  instance.subscription = Subscription:create()
  instance.sink_ref = sink
  instance.fn_name = 'k' .. unique_id()
  instance.handle_all = handle_all

  if type(sink) == 'function' then
    instance.sink_ref = Funcref:create(sink)
    instance.subscription:add(instance.sink_ref.subscription)
  end

  return setmetatable(instance, {
    __index = Fzf
  })
end

-- Executes with the given args
-- @param cmd Fzf args minus the sink
function Fzf:execute(cmd)
  nvim.g[self.fn_name] = cmd

  if type(self.sink_ref) ~= 'string' then
    nvim.command(('let g:%s["sink%s"] = %s'):format(self.fn_name, self.handle_all and '*' or '', self.sink_ref:get_vim_ref_string()))
  else
    nvim.command(('let g:%s["sink"] = "%s"'):format(self.fn_name, self.sink_ref))
  end

  nvim.command(('call fzf#run(fzf#wrap(g:%s))'):format(self.fn_name))
  nvim.command('unlet g:' .. self.fn_name)
end

-- Cleans up this fzf executor
function Fzf:unsubscribe()
  self.subscription:unsubscribe()
end

-- Creates a floating window for use with fzf
-- @param on_close An optional on close handler executed when the buffer is detached
function Fzf.create_floating_window(on_close)
  local buf = nvim.create_buf(false, true)
  local columns = nvim.o.columns
  local lines = nvim.o.lines
  local width = math.floor(columns - (columns * 2 / 10))
  local height = lines - 3
  local y = height
  local x = math.floor((columns - width) / 2)

  if on_close then
    nvim.buf_attach(buf, false, {
      on_detach = vim.schedule_wrap(on_close)
    })
  end

  nvim.fn.setbufvar(buf, '&signcolumn', 'no' )
  nvim.open_win(buf, true, { relative = 'editor', row = y, col = x, width = width, height = height })
  nvim.ex.setlocal 'winblend=10'
end

-- Gets the execution string used in FZF config options
-- @param on_close Optional handler to call on buffer detachment
function Fzf.float_window(on_close)
  if on_close then
    local fn_ref = Funcref:create(function(ref)
      on_close()
      ref:unsubscribe()
    end)

    return ("lua require('fzf/fzf').create_floating_window(%s)"):format(fn_ref:get_lua_ref_string())
  end

  return [[lua require('fzf/fzf').create_floating_window()]]
end

return Fzf
