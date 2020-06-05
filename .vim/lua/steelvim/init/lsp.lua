local lsp = require 'nvim_lsp'
local configs = require 'steelvim/lsp/configs'
local lsp_status = require 'lsp-status'

lsp_status.register_progress()

for server,config in pairs(configs) do
  lsp[server].setup(steel.lsp.get_config(config))
end
