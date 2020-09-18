local M = {}

local DiagnosticSeverity = vim.lsp.protocol.DiagnosticSeverity

M.error_display = {
  [DiagnosticSeverity.Error] = { text = "Error"; color = steel.ansi.red };
  [DiagnosticSeverity.Warning] = { text = "Warning"; color = steel.ansi.yellow };
  [DiagnosticSeverity.Information] = { text = "Info"; color = steel.ansi.blue };
  [DiagnosticSeverity.Hint] = { text = "Hint"; color = function(t) return t end};
}

local fzf = steel.fzf:create(function(_, _, data)
  steel.lsp.handle_location_items(data, function(item)
    return steel.lsp.uri_to_location(item.uri, item.range.start.line, item.range.start.character)
  end)
end, { handle_all = true; indexed_data = true; })

local function format_diagnostics(items)
  return steel.fzf.grid_to_source(
    steel.fzf.create_grid({
      { heading = "Message"; length = 60; map = steel.ansi.red; truncate = true; },
      { heading = "Severity"; length = 15; map = steel.ansi.red; },
      { heading = "Loc"; length = 12; map = steel.ansi.red; },
      { heading = "File"; map = steel.ansi.red; }
    }, steel.fn.map(items, function(item, index)
      local error_display = M.error_display[item.severity]

      return {
        { value = item.message; },
        { value = error_display.text; map = error_display.color; },
        {
          value = item.range.start.line .. ":" .. item.range.start.character;
          map = steel.ansi.blue
        },
        { value = item.uri or "N/A"; map = steel.ansi.cyan },
        tostring(index)
      }
    end))
  )
end

local function get_diagnostics(options)
  options = options or {}

  local result = {}

  if options.bufnr then
    result = vim.lsp.util.diagnostics_by_buf[options.bufnr] or {}
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

  return result
end

function M.open_diagnostics(options)
  local bufnr = options and options.bufnr or nil
  local diagnostics = get_diagnostics(options)
  local source = format_diagnostics(diagnostics, bufnr)

  fzf:execute {
    options = { "--ansi", "--multi", "--header-lines=1" };
    source = source;
    window = steel.fzf.float_window();
    data = diagnostics;
  }
end

return M
