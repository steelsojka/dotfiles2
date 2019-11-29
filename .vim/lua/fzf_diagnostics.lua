local nvim = require 'nvim'
local utils = require 'utils'
local fzf = require 'fzf_utils'

local executor 

local function format_diagnostic(item, key)
  return (item.file ~= nil and nvim.fn.bufname(item.file) or '')
    .. '|' .. (item.lnum ~= nil and item.lnum or '')
    .. (item.col ~= nil and (' ' .. item.col) or ' 0')
    .. '| ' .. item.severity
    .. ': ' .. item.message
end

local function get_diagnostics(file_only)
  local diagnostics = nvim.fn.CocAction('diagnosticList')

  if file_only then
    local current_file = nvim.fn.expand('%:p')

    diagnostics = utils.filter(diagnostics, function(item, key)
      return item.file == current_file
    end)
  end

  return utils.map(diagnostics, format_diagnostic) 
end

local function open_diagnostics(file_only)
  local diagnostics = get_diagnostics(file_only)
  local opts = {
    source = diagnostics,
    window = 'lua steelvim.float_fzf()'
  }

  executor(opts)
end

local function handle_selection(line)
  local file, lnum, col, error_msg = line:match('(.-)[|]([0-9]+) ([0-9]+)[|](.*)')

  if file then
    nvim.ex.buffer(nvim.fn.bufnr(file))
    nvim.ex.mark("'")

    if lnum and col then
      nvim.fn.cursor(lnum, col)
      nvim.ex.normal_('zvzz')
    end
  end
end

executor = fzf.create_executor(handle_selection, false)

return {
  open_diagnostics = open_diagnostics
}
