local M = {}

-- Prompts for input to a command
-- @param command Command to run with search term
-- @param prompt Prompt text
function M.prompt_command(command, prompt)
  local search_term = vim.fn.input(('%s: '):format(prompt))

  if string.len(search_term) > 0 then
    steel.command(('%s %s'):format(command, search_term))
  end
end

function M.show_documentation(show_errors)
  if show_errors then
    local error_result = vim.lsp.util.show_line_diagnostics()

    if error_result ~= nil then
      return
    end
  end

  if vim.fn.index({ 'vim', 'lua', 'help' }, vim.bo.filetype) >= 0 then
    steel.ex.help(vim.fn.expand('<cword>'))
  else
    vim.lsp.buf.hover()
  end
end

return M
