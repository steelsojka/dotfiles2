local lsp = require 'nvim_lsp'
local configs = require 'steelvim/lsp/configs'
local lsp_status = require 'lsp-status'

lsp_status.register_progress {
  kind_labels = vim.g.completion_customize_lsp_label
}

for server,config in pairs(configs) do
  lsp[server].setup(steel.lsp.get_config(config))
end
