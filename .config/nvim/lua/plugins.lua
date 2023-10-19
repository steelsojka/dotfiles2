return {
  {
    "folke/which-key.nvim",
    pager = true},
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    pager = true,
    lazy = false},
  "b3nj5m1n/kommentary",
  {
    "itchyny/lightline.vim",
    pager = true,
    lazy = false},
  "tpope/vim-fugitive",
  {"mbbill/undotree", cmd = "UndotreeToggle"},
  "tpope/vim-surround",
  {"stevearc/oil.nvim", cmd = "Oil"},
  "arthurxavierx/vim-caser",
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {"nvim-tree/nvim-web-devicons"}},
  {
    "norcalli/nvim-colorizer.lua",
    pager = true},
  {"tpope/vim-dispatch", cmd = "Dispatch"},
  {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    dependencies = {"nvim-lua/plenary.nvim"}},
  "editorconfig/editorconfig-vim",
  "nvim-treesitter/nvim-treesitter",
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim"}},
  "nvim-telescope/telescope-ui-select.nvim",
  "stevearc/dressing.nvim",
  {
    "jpalardy/vim-slime",
    cmd = {
      "SlimeSendCurrentLine",
      "SlimeSend"}},
  "bakpakin/fennel.vim",
  {"mfussenegger/nvim-jdtls", ft = "java"},
  {"mfussenegger/nvim-dap", lazy = true},
  {
    "NTBBloodbath/rest.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    ft = "http"},
  {
    "phaazon/hop.nvim",
    branch = 'v1',
    pager = true,
    cmd = {
      "HopChar2",
      "HopChar1",
      "HopWord",
      "HopPattern"}},
  {"mhartington/formatter.nvim", cmd = "Format"},
  {
    "Olical/conjure",
    ft = {"fennel", "clojure"},
    tag = "v4.9.0"},
  "windwp/nvim-autopairs",
  {"iamcco/markdown-preview.nvim", ft = "markdown"},

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip" }},

  -- Snippets
  "hrsh7th/vim-vsnip",
  "hrsh7th/vim-vsnip-integ",

  -- Lsp
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    dependencies = {"williamboman/mason-lspconfig.nvim"}},
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = {"TroubleToggle", "Trouble"}},
  {"nvim-lua/lsp-status.nvim", lazy = true},

  -- Productivity
  {
    "weirongxu/plantuml-previewer.vim",
    ft = {"uml", "puml", "plantuml"},
    dependencies = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax"}}}
