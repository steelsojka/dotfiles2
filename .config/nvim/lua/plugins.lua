local plugins = {
  {"wbthomason/packer.nvim", opt = true},
  "lewis6991/impatient.nvim",
  "liuchengxu/vim-which-key",
  {"junegunn/fzf", alias = "fzf-core"},
  "junegunn/fzf.vim",
  "folke/tokyonight.nvim",
  {
    "b3nj5m1n/kommentary",
    keys = {
      "<Plug>kommentary_line_default",
      "<Plug>kommentary_visual_default"}
  },
  "itchyny/lightline.vim",
  "tpope/vim-fugitive",
  {"mbbill/undotree", cmd = "UndotreeToggle"},
  "tpope/vim-surround",
  "justinmk/vim-dirvish",
  "kristijanhusak/vim-dirvish-git",
  "arthurxavierx/vim-caser",
  "mhinz/vim-startify",
  "norcalli/nvim-colorizer.lua",
  "tpope/vim-dispatch",
  "so-fancy/diff-so-fancy",
  {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    requires = {"nvim-lua/plenary.nvim"}
  },
  "editorconfig/editorconfig-vim",
  "sheerun/vim-polyglot",
  {"nvim-treesitter/playground", opt = true, cmd = "TSPlaygroundToggle"},
  "nvim-treesitter/nvim-treesitter",
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim"}
  },
  "nvim-telescope/telescope-ui-select.nvim",
  "stevearc/dressing.nvim",
  "jpalardy/vim-slime",
  {"Olical/aniseed", tag = "v3.24.0", opt = true},
  "bakpakin/fennel.vim",
  "mfussenegger/nvim-jdtls",
  "mfussenegger/nvim-dap",
  {
    "NTBBloodbath/rest.nvim",
    requires = {"nvim-lua/plenary.nvim"}
  },
  {
    "phaazon/hop.nvim",
    branch = 'v1'
  },
  "mhartington/formatter.nvim",
  {
    "Olical/conjure",
    ft = {"fennel", "clojure"},
    tag = "v4.9.0"
  },
  "windwp/nvim-autopairs",
  "iamcco/markdown-preview.nvim",

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip"
    }
  },

  -- Snippets
  "hrsh7th/vim-vsnip",
  "hrsh7th/vim-vsnip-integ",

  -- Lsp
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons"
  },
  "nvim-lua/lsp-status.nvim",

  -- Productivity
  "kristijanhusak/orgmode.nvim",
  {
    "weirongxu/plantuml-previewer.vim",
    requires = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax"}
  }
}

return plugins
