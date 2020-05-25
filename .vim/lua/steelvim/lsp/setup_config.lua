local completion = require 'completion'
local diagnostic = require 'diagnostic'
local callbacks = require 'steelvim/lsp/callbacks'

local M = {}

function M.get_config(overrides)
  return vim.tbl_extend('force', {
    on_attach = function()
      completion.on_attach()
      diagnostic.on_attach()
    end;
    callbacks = callbacks.get_callbacks();
  }, overrides or {})
end

return M
