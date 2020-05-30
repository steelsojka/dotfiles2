local fzf_lsp = require 'steelvim/lsp/lsp_fzf'

local M = {}

function M.get_callbacks(overrides)
  return vim.tbl_extend('force', {
    ['workspace/symbol'] = fzf_lsp.symbol_callback;
    ['textDocument/documentSymbol'] = fzf_lsp.symbol_callback;
    ['textDocument/references'] = fzf_lsp.location_callback;
    ['textDocument/codeAction'] = fzf_lsp.code_action_callback;
    ['textDocument/declaration'] = fzf_lsp.location_callback;
    ['textDocument/definition'] = fzf_lsp.location_callback;
    ['textDocument/typeDefinition'] = fzf_lsp.location_callback;
    ['textDocument/implementation'] = fzf_lsp.location_callback;
  }, overrides or {})
end

return M
