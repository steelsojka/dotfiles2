-- Opens terminal to the cwd or to the current files directory.
-- @param is_local Whether to open local to the current file directory
function steelvim_open_term(is_local)
  if is_local then 
    cwd = vim.api.nvim_call_function('expand', { '%:p:h' })
  else
    cwd = vim.api.nvim_call_function('getcwd', {})
  end

  buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_call_function('termopen', { vim.api.nvim_eval('&shell'), { cwd = cwd } })
  vim.api.nvim_command('normal i')
end
