local completion = require 'completion'
local diagnostic = require 'diagnostic'
local callbacks = require 'steelvim/lsp/callbacks'

local M = {}

function M.on_attach(client)
  diagnostic.on_attach()

  if client.resolved_capabilities['document_highlight'] then
    steel.mappings.create_autocmds {
      { 'CursorHold', '<buffer>', function() vim.lsp.buf.document_highlight() end };
      { 'CursorHoldI', '<buffer>', function() vim.lsp.buf.document_highlight() end };
      { 'CursorMoved', '<buffer>', function() vim.lsp.buf.clear_references() end };
    }
  end

  steel.mappings.register_buffer_mappings {
    ['ngd'] = { function() vim.lsp.buf.definition() end, silent = true };
    ['ngy'] = { function() vim.lsp.buf.type_definition()  end, silent = true };
    ['ngi'] = { function() vim.lsp.buf.implementation() end, silent = true };
    ['ngr'] = { function() vim.lsp.buf.references()  end, silent = true };
    ['i<C-Space>'] = { function() vim.lsp.omnifunc() end, silent = true };
  }
end

function M.get_config(overrides)
  return vim.tbl_extend('force', {
    on_attach = M.on_attach;
    callbacks = callbacks.get_callbacks();
  }, overrides or {})
end

return M
