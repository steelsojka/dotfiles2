local modes = {
  MAN_PAGER = "man_pager",
  GIT_PAGER = "git_pager",
  GIT = "git"
}

return {
  {
    "folke/which-key.nvim",
    modes = {
      modes.MAN_PAGER,
      modes.GIT_PAGER}},
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    modes = {
      modes.MAN_PAGER,
      modes.GIT_PAGER,
      modes.GIT},
    lazy = false},
  "b3nj5m1n/kommentary",
  {
    "itchyny/lightline.vim",
    modes = {
      modes.MAN_PAGER,
      modes.GIT_PAGER},
    lazy = false},
  {"mbbill/undotree", cmd = "UndotreeToggle"},
  "tpope/vim-surround",
  {"stevearc/oil.nvim"},
  "arthurxavierx/vim-caser",
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {"nvim-tree/nvim-web-devicons"}},
  {
    "norcalli/nvim-colorizer.lua",
    modes = {
      modes.MAN_PAGER,
      modes.GIT,
      modes.GIT_PAGER}},
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
    modes = {modes.GIT},
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim"}},
  {
    "nvim-telescope/telescope-ui-select.nvim",
    modes = {modes.GIT}},
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
    modes = {
      modes.MAN_PAGER,
      modes.GIT_PAGER},
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
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim"},
    modes = {modes.GIT}},
  {
    "FabijanZulj/blame.nvim",
    cmd = {"ToggleBlame", "EnableBlame"},
    config = true},

  -- Productivity
  {
    "weirongxu/plantuml-previewer.vim",
    ft = {"uml", "puml", "plantuml"},
    dependencies = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax"}}}
