local M = {}

function M.get_status_line()
  local count = vim.lsp.util.buf_diagnostics_count('Error')

  return (type(count) == 'number' and count > 0) and 'E:' .. count or ''
end

return M
