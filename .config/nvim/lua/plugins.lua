local modes = require "steelvim.modes"

return {
  {
    "folke/which-key.nvim",
    modes = modes.ALL},
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    modes = modes.ALL,
    lazy = false},
  "b3nj5m1n/kommentary",
  {
    "itchyny/lightline.vim",
    modes = modes.ALL,
    lazy = false},
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    modes = {modes.GIT_DIFF}},
  {
    "tpope/vim-surround",
    modes = {modes.GIT_DIFF}},
  "stevearc/oil.nvim",
  {
    "arthurxavierx/vim-caser",
    modes = {modes.GIT_DIFF}},
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {"nvim-tree/nvim-web-devicons"}},
  {
    "norcalli/nvim-colorizer.lua",
    modes = modes.ALL},
  {"tpope/vim-dispatch", cmd = "Dispatch"},
  {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    dependencies = {"nvim-lua/plenary.nvim"}},
  {
    "editorconfig/editorconfig-vim",
    modes = {modes.GIT_DIFF}},
  {
    "nvim-treesitter/nvim-treesitter",
    modes = {modes.GIT_DIFF}},
  {
    "nvim-telescope/telescope.nvim",
    modes = {
      modes.GIT,
      modes.GIT_DIFF},
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim"}},
  {
    "nvim-telescope/telescope-ui-select.nvim",
    modes = {
      modes.GIT,
      modes.GIT_DIFF}},
  {
    "stevearc/dressing.nvim",
    modes = {modes.GIT_DIFF}},
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
      modes.GIT_PAGER,
      modes.GIT_DIFF},
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
  {
    "windwp/nvim-autopairs",
    modes = {modes.GIT_DIFF}},
  {"iamcco/markdown-preview.nvim", ft = "markdown"},

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    modes = {modes.GIT_DIFF},
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
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"},
    modes = {modes.GIT}},
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
      "sindrets/diffview.nvim"},
    modes = {modes.GIT}},
  {
    "FabijanZulj/blame.nvim",
    cmd = {"ToggleBlame", "EnableBlame"},
    config = true},
  {
    "stevearc/aerial.nvim",
    cmd = {"AerialOpen", "AerialNavOpen"},
    modes = {modes.GIT_DIFF},
    config = true},
  {
    "nvim-pack/nvim-spectre",
    dependencies = {"nvim-lua/plenary.nvim"},
    modes = {modes.GIT},
    lazy = true},
  "onsails/lspkind.nvim",
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({})
    end},
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"}},

  -- Productivity
  {
    "weirongxu/plantuml-previewer.vim",
    ft = {"uml", "puml", "plantuml"},
    dependencies = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax"}}}
