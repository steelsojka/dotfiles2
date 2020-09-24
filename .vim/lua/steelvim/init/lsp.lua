local lsp = require 'nvim_lsp'
local configs = require 'steelvim/lsp/configs'

for server,config in pairs(configs) do
  lsp[server].setup(steel.lsp.get_config(config))
end
