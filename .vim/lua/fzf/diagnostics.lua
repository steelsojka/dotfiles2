-- Uses FZF to filter diagnostics from Coc.nvim

local nvim = require 'nvim'
local utils = require 'utils/utils'
local Fzf = require 'fzf/fzf'

local M = {}

local fzf = Fzf:create(function(_, line)
  local uri, lnum, col = line:match('(.-)[|]([0-9]+) ([0-9]+)[|](.*)')

  if uri then
    nvim.ex.buffer(vim.uri_to_bufnr(uri))
    nvim.ex.mark("'")

    if lnum and col then
      vim.fn.cursor(lnum + 1, col + 1)
      nvim.ex.normal_('zvzz')
    end
  end
end, false)

local function format_diagnostic(item, key)
  return (item.uri ~= nil and item.uri or '')
    .. '|' .. (item.range.start.line ~= nil and item.range.start.line or '')
    .. (item.range.start.character ~= nil and (' ' .. item.range.start.character) or ' 0')
    .. '| ' .. item.severity
    .. ': ' .. item.message
end

local function get_diagnostics(options)
  options = options or {}

  local result = {}

  if options.bufnr then
    result = vim.lsp.util.diagnostics[options.bufnr] or {}
  else 
    for buf,diagnostics in pairs(vim.lsp.util.diagnostics_by_buf) do
      if options.filetype then
        diagnostics = utils.filter(diagnostics, function(diagnostic)
          return diagnostic.source == options.filetype
        end)
      end

      print(vim.inspect(diagnostics))

      result = utils.concat(result, diagnostics)
    end
  end

  -- print(vim.inspect(result))

  return utils.map(result, format_diagnostic) 
end

function M.open_diagnostics(file_only)
  local diagnostics = get_diagnostics(file_only)
  local opts = {
    source = diagnostics,
    window = Fzf.float_window()
  }

  fzf:execute(opts)
end

return M 
