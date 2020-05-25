local symbols = require 'steelvim/lsp/symbols'

local M = {}

function M.get_callbacks(overrides)
  return vim.tbl_extend('force', {
    ['textDocument/documentSymbol'] = symbols.symbol_callback;
    ['workspace/symbol'] = symbols.symbol_callback;
  }, overrides or {})
end

return M
