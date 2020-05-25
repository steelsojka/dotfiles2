local Fzf = {}

-- Creates an FZF executor for running FZF in lua
-- @param sink Function to execute with selected line(s)
-- @param handle_all Whether to handle all lines or call the sink for each line
function Fzf:create(sink, handle_all)
  local instance = {}

  instance.subscription = steel.rx.subscription:create()
  instance.sink_ref = sink
  instance.fn_name = 'k' .. steel.utils.unique_id()
  instance.handle_all = handle_all

  if type(sink) == 'function' then
    instance.sink_ref = steel.utils.funcref:create(sink)
    instance.subscription:add(instance.sink_ref.subscription)
  end

  return setmetatable(instance, {
    __index = Fzf
  })
end

-- Executes with the given args
-- @param cmd Fzf args minus the sink
function Fzf:execute(cmd)
  vim.g[self.fn_name] = cmd

  if type(self.sink_ref) ~= 'string' then
    steel.command(('let g:%s["sink%s"] = %s'):format(self.fn_name, self.handle_all and '*' or '', self.sink_ref:get_vim_ref_string()))
  else
    steel.command(('let g:%s["sink"] = "%s"'):format(self.fn_name, self.sink_ref))
  end

  steel.command(('call fzf#run(fzf#wrap(g:%s))'):format(self.fn_name))
  steel.command('unlet g:' .. self.fn_name)
end

-- Cleans up this fzf executor
function Fzf:unsubscribe()
  self.subscription:unsubscribe()
end

-- Creates a floating window for use with fzf
-- @param on_close An optional on close handler executed when the buffer is detached
function Fzf.create_floating_window(on_close)
  local buf = vim.api.nvim_create_buf(false, true)
  local columns = vim.o.columns
  local lines = vim.o.lines
  local width = math.floor(columns - (columns * 2 / 20))
  local height = lines - 3
  local y = height
  local x = math.floor((columns - width) / 2)

  if on_close then
    vim.api.nvim_buf_attach(buf, false, {
      on_detach = vim.schedule_wrap(on_close)
    })
  end

  vim.fn.setbufvar(buf, '&signcolumn', 'no' )
  vim.api.nvim_open_win(buf, true, { relative = 'editor', row = y, col = x, width = width, height = height })
  steel.ex.setlocal 'winblend=10'
end

-- Gets the execution string used in FZF config options
-- @param on_close Optional handler to call on buffer detachment
function Fzf.float_window(on_close)
  if on_close then
    local fn_ref = steel.utils.funcref:create(function(ref)
      on_close()
      ref:unsubscribe()
    end)

    return ("lua require('steelvim/fzf').create_floating_window(%s)"):format(fn_ref:get_lua_ref_string())
  end

  return [[lua require('steelvim/fzf').create_floating_window()]]
end

return Fzf
