local colorizer = require 'colorizer'

require 'steelvim'

steel.ex.colorscheme "OceanicNext"

require 'steelvim/lsp/angularls'
require 'steelvim/lsp/jdtls'

require 'steelvim/init/settings'
require 'steelvim/init/globals'
require 'steelvim/init/global_mappings'
require 'steelvim/init/filetypes'
require 'steelvim/init/commands'
require 'steelvim/init/lsp'

require "colorizer".setup {
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

require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true;
    disable = { 'typescript' }
  };
}
