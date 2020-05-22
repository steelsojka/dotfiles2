local nvim = require 'nvim'
local utils = require 'steelvim/utils/utils'

local M = {}

-- Prompts for input to a command
-- @param command Command to run with search term
-- @param prompt Prompt text
function M.prompt_command(command, prompt)
  local search_term = vim.fn.input(('%s: '):format(prompt))

  if string.len(search_term) > 0 then
    nvim.command(('%s %s'):format(command, search_term))
  end
end

function M.show_documentation(show_errors)
  if show_errors then
    local error_result = vim.lsp.util.show_line_diagnostics()

    if error_result ~= nil then
      return
    end
  end

  if vim.fn.index({ 'vim', 'lua', 'help' }, nvim.bo.filetype) >= 0 then
    nvim.ex.help(vim.fn.expand('<cword>'))
  else
    vim.lsp.buf.hover()
  end
end

function M.cycle_property(current, values, setter)
  local _, current_index = utils.find(values, function(v) return v == current end)
  local next_index = current_index + 1 > #values and 0 or current_index + 1

  setter(values[next_index])
end

return M
