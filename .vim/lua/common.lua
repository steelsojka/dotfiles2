local nvim = require 'nvim'
local utils = require 'utils/utils'

-- Prompts for input to a command
-- @param command Command to run with search term
-- @param prompt Prompt text
local function prompt_command(command, prompt)
  local search_term = nvim.fn.input(prompt .. ': ')

  if string.len(search_term) > 0 then
    nvim.command(command .. ' ' .. search_term)
  end
end

local function show_documentation()
  if nvim.fn.index({ 'vim', 'lua', 'help' }, nvim.bo.filetype) >= 0 then
    nvim.ex.help(nvim.fn.expand('<cword>'))
  else
    nvim.fn.CocAction 'doHover'
  end
end

return {
  prompt_command = prompt_command,
  show_documentation = show_documentation
}
