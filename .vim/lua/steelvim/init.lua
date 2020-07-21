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
  tree_docs = {
    enable = true,
    keymaps = {
      doc_node_at_cursor = '<leader>dd',
      doc_all_in_range = '<leader>dd'
    }
  };
  highlight = { enable = true };
  refactor = {
    highlight_definitions = { enable = true };
    smart_rename = { enable = true };
    navigation = { enable = true };
  };
  ensure_installed = {
    "typescript",
    "html",
    "lua",
    "javascript",
    "json",
    "java",
    "css",
    "c"
  };
}
