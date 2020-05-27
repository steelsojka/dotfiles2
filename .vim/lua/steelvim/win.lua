local M = {}

function M.create_floating_window(on_close)
  local buf = vim.api.nvim_create_buf(false, true)
  local columns = vim.o.columns
  local lines = vim.o.lines
  local width = math.floor(columns - (columns * 2 / 20)) local height = lines - 3
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
function M.float_window(on_close)
  if on_close then
    local fn_ref = steel.utils.funcref:create(function(ref)
      on_close()
      ref:unsubscribe()
    end)

    return ("lua steel.win.create_floating_window(%s)"):format(fn_ref:get_lua_ref_string())
  end

  return [[lua steel.win.create_floating_window()]]
end

return M
