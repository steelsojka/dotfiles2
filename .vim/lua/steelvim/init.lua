local colorizer = require "colorizer"

require "steelvim"

steel.ex.colorscheme "OceanicNext"

require "steelvim/lsp/angularls"
require "steelvim/init/settings"
require "steelvim/init/globals"
require "steelvim/init/global_mappings"
require "steelvim/init/filetypes"
require "steelvim/init/commands"
require "steelvim/init/lsp"
require "steelvim/init/snippets"

require "colorizer".setup {
  "css",
  "sass",
  "less",
  "typescript",
  "javascript",
  "vim",
  "html",
  "jst",
  "lua"
}

require "snippets".use_suggested_mappings()

require "nvim-treesitter.configs".setup {
  tree_docs = {
    enable = true,
    keymaps = {
      doc_node_at_cursor = "<leader>dd",
      doc_all_in_range = "<leader>dd"
    }
  };
  playground = { enable = true, persist_queries = true };
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner"
      }
    }
  };
  highlight = { enable = true };
  semantic_highlight = { enable = true };
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
    "c",
    "query"
  };
}
