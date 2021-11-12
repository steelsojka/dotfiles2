local plugins = {
  {"wbthomason/packer.nvim", opt = true},
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
    requires = {
      "nvim-lua/plenary.nvim"}
  },
  "editorconfig/editorconfig-vim",
  "sheerun/vim-polyglot",
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter",
  {
    "nvim-treesitter/nvim-tree-docs",
    after = "nvim-treesitter"
  },
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim"}
  },
  "nvim-telescope/telescope-fzy-native.nvim",
  "jhawthorn/fzy",
  "jpalardy/vim-slime",
  {"Olical/aniseed", tag = "v3.24.0", opt = true},
  "bakpakin/fennel.vim",
  "mfussenegger/nvim-jdtls",
  "mfussenegger/nvim-dap",
  "diepm/vim-rest-console",
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
  "steelsojka/pears.nvim",
  "steelsojka/headwind.nvim",
  "iamcco/markdown-preview.nvim",

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-vsnip",

  -- Snippets
  "hrsh7th/vim-vsnip",
  "hrsh7th/vim-vsnip-integ",

  -- Lsp
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer",

  -- Productivity
  "kristijanhusak/orgmode.nvim"
}

return plugins
