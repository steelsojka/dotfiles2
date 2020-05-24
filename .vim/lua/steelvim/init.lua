local nvim = require 'nvim'
local colorizer = require 'colorizer'

nvim.ex.colorscheme('OceanicNext')

require 'steelvim/lsp/angularls'
require 'steelvim/lsp/jdtls'

require 'steelvim/init/settings'
require 'steelvim/init/globals'
require 'steelvim/init/global_mappings'
require 'steelvim/init/filetypes'
require 'steelvim/init/commands'
require 'steelvim/init/lsp'

colorizer.setup {
  'css',
  'sass',
  'less',
  'typescript',
  'javascript',
  'vim',
  'html',
  'jst',
  'lua'
}
