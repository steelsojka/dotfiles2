local M = {}

local fzf = steel.fzf:create(function(_, line)
  local uri, lnum, col = line:match('(.-)[|]([0-9]+) ([0-9]+)[|](.*)')

  if uri then
    steel.ex.buffer(vim.uri_to_bufnr(uri))
    steel.ex.mark("'")

    if lnum and col then
      vim.fn.cursor(lnum + 1, col + 1)
      steel.command("normal! zvzz")
    end
  end
end, false)

local function format_diagnostic(item, _)
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
    for _,diagnostics in pairs(vim.lsp.util.diagnostics_by_buf) do
      if options.filetype then
        diagnostics = steel.fn.filter(diagnostics, function(diagnostic)
          return diagnostic.source == options.filetype
        end)
      end

      result = steel.fn.concat(result, diagnostics)
    end
  end

  return steel.fn.map(result, format_diagnostic)
end

function M.open_diagnostics(file_only)
  local diagnostics = get_diagnostics(file_only)
  local opts = {
    source = diagnostics,
    window = Fzf.float_window()
  }

  fzf:execute(opts)
end

function M.get_status_line()
  local count = vim.lsp.util.buf_diagnostics_count('Error')

  return (type(count) == 'number' and count > 0) and 'E:' .. count or ''
end

return M
