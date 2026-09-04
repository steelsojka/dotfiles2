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
  -- {"tpope/vim-dispatch", cmd = "Dispatch"},
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
--[[   {
    "nvim-treesitter/nvim-treesitter-context",
    modes = {modes.GIT_DIFF},
    dependencies = {"nvim-treesitter/nvim-treesitter"}}, ]]
  { "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require "snacks".setup {
        picker = { enabled = true },
        image = { enabled = true }
      }
    end },
--[[   {
    "stevearc/dressing.nvim",
    modes = {modes.GIT_DIFF}}, ]]
--[[   {
    "jpalardy/vim-slime",
    cmd = {
      "SlimeSendCurrentLine",
      "SlimeSend"}}, ]]
  "bakpakin/fennel.vim",
--[[   {"mfussenegger/nvim-jdtls", ft = "java"},
  {"mfussenegger/nvim-dap", lazy = true}, ]]
--[[   {
    "NTBBloodbath/rest.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    ft = "http"}, ]]
  {
    "wsdjeg/hop.nvim",
    tag = "v2.8.1",
    modes = {
      modes.MAN_PAGER,
      modes.GIT_PAGER,
      modes.GIT_DIFF},
    cmd = {
      "HopChar2",
      "HopChar1",
      "HopWord",
      "HopPattern"}},
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          html = { "prettier" }
        },
        notify_no_formatters = true
      }
    end},
  {
    "Olical/conjure",
    ft = {"fennel", "clojure"},
    tag = "v4.9.0"},
  {
    "windwp/nvim-autopairs",
    modes = {modes.GIT_DIFF}},
--[[   {"iamcco/markdown-preview.nvim", ft = "markdown"}, ]]

  -- Completion
  {
    "saghen/blink.cmp",
    name = "blink-cmp",
    version = "1.*"},

  -- Lsp
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    dependencies = {"williamboman/mason-lspconfig.nvim"}},
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
    cmd = "Trouble"},
  {"nvim-lua/lsp-status.nvim", lazy = true},
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"},
    modes = {modes.GIT}},
--[[   {
    "nvim-orgmode/orgmode",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"},
    event = "VeryLazy"}, ]]
   {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "sindrets/diffview.nvim"},
    modes = {modes.GIT}},
   {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup {}
    end},
--[[   {
    "stevearc/aerial.nvim",
    cmd = {"AerialOpen", "AerialNavOpen"},
    modes = {modes.GIT_DIFF},
    config = true}, ]]
  {
    "nvim-pack/nvim-spectre",
    dependencies = {"nvim-lua/plenary.nvim"},
    modes = {modes.GIT},
    lazy = true},
--[[   {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
       "saghen/blink.cmp",
    },
    config = function()
        require("codeium").setup({})
    end} ]]
--[[   modes.mixin_mode({
    "jackMort/ChatGPT.nvim",
    modes = {modes.GPT},
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"}},
    {
      [modes.GPT] = function(def)
        def.event = nil
      end}), ]]

  -- Productivity
--[[   {
    "weirongxu/plantuml-previewer.vim",
    ft = {"uml", "puml", "plantuml"},
    dependencies = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax"}} ]]
}
