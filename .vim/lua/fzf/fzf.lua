local Subscription = require 'subscription'
local Funcref = require 'funcref'
local nvim = require 'nvim'

local Fzf = {}

function Fzf:create(sink, handle_all)
  local instance = {}

  instance.subscription = Subscription:create()
  instance.sink_ref = sink
  instance.fn_name = 'k' .. math.random(0, 1000000)
  instance.handle_all = handle_all

  if type(sink) == 'function' then
    instance.sink_ref = Funcref:create(sink)
    instance.subscription:add(instance.sink_ref.subscription)
  end

  return setmetatable(instance, {
    __index = Fzf
  })
end

function Fzf:execute(cmd)
  nvim.g[self.fn_name] = cmd

  if type(self.sink_ref) ~= 'string' then
    nvim.command('let g:' .. self.fn_name .. '["sink' .. (self.handle_all and '*' or '') .. '"] = ' .. self.sink_ref:getRefString())
  else
    nvim.command('let g:' .. self.fn_name .. '["sink"] = "' .. self.sink_ref .. '"')
  end

  nvim.command('call fzf#run(fzf#wrap(g:' .. self.fn_name ..'))')
  nvim.command('unlet g:' .. self.fn_name)
end

function Fzf:unsubscribe()
  self.subscription:unsubscribe()
end

function Fzf.create_floating_window()
  local buf = nvim.create_buf(false, true)
  local columns = nvim.o.columns
  local lines = nvim.o.lines
  local width = math.floor(columns - (columns * 2 / 10))
  local height = lines - 3
  local y = height
  local x = math.floor((columns - width) / 2)

  nvim.fn.setbufvar(buf, '&signcolumn', 'no' )
  nvim.open_win(buf, true, { relative = 'editor', row = y, col = x, width = width, height = height })
  nvim.ex.setlocal 'winblend=10'
end

function Fzf.float_window()
  return [[lua require('fzf/fzf').create_floating_window()]]
end

return Fzf
