require "plugin_loader".setup(function()
  use {"wbthomason/packer.nvim", opt = true}
  use "liuchengxu/vim-which-key"

  use {
    "junegunn/fzf",
    run = function(conf)
      vim.cmd(string.format("!%s/install --all", conf.install_path))
      vim.cmd(string.format("!ln -s %s ~/.fzf", conf.install_path))
    end}

  use "junegunn/fzf.vim"
  use "folke/tokyonight.nvim"

  use {
    "b3nj5m1n/kommentary",
    keys = {
      "<Plug>kommentary_line_default",
      "<Plug>kommentary_visual_default"}}

  use "itchyny/lightline.vim"
  use "tpope/vim-fugitive"
  use {"mbbill/undotree", cmd = "UndotreeToggle"}
  use "tpope/vim-surround"
  use "justinmk/vim-dirvish"
  use "kristijanhusak/vim-dirvish-git"
  use "arthurxavierx/vim-caser"
  use "mhinz/vim-startify"

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "plugin_loader".configure "colorizer"
    end}
  use "tpope/vim-dispatch"

  use {
    "so-fancy/diff-so-fancy",
    run = function(conf)
      vim.cmd(string.format("!ln -s %s/diff-so-fancy ~/bin/diff-so-fancy", conf.install_path))
    end}

  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    config = function()
      require "plugin_loader".configure "gitsigns"
    end,
    requires = {
      "nvim-lua/plenary.nvim"}}

  use "editorconfig/editorconfig-vim"
  use "sheerun/vim-polyglot"
  use "nvim-treesitter/playground"

  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "plugin_loader".configure "nvim-treesitter"
    end,
    run = ":TSUpdate"}

  use {
    "nvim-treesitter/nvim-tree-docs",
    after = "nvim-treesitter"}

  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "plugin_loader".configure "telescope"
    end,
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim"}}
  use "nvim-telescope/telescope-fzy-native.nvim"

  use {
    "jhawthorn/fzy",
    run = "PREFIX=$HOME make && PREFIX=$HOME make install"}
  use {
    "jpalardy/vim-slime",
    run = "npm install -g ts-node"}
  use {"Olical/aniseed", tag = "v3.24.0", opt = true}

  use "bakpakin/fennel.vim"

  use {
    "mfussenegger/nvim-jdtls",
    config = function()
      require "plugin_loader".configure "jdtls"
    end}

  use {
    "mfussenegger/nvim-dap",
    config = function()
      require "plugin_loader".configure "dap"
    end}

  use "diepm/vim-rest-console"

  use {
    "phaazon/hop.nvim",
    branch = 'v1',
    config = function()
      require "plugin_loader".configure "hop"
    end}

  use {
    "mhartington/formatter.nvim",
    config = function()
      require "plugin_loader".configure "formatter"
    end,
    run = function()
      vim.cmd "!npm install -g prettier"
      vim.cmd "!npm install -g eslint"
    end}

  use {
    "Olical/conjure",
    ft = {"fennel", "clojure"},
    tag = "v4.9.0"}

  use {
    "steelsojka/pears.nvim",
    config = function()
      require "plugin_loader".configure "pears"
    end}

  use {
    "steelsojka/headwind.nvim",
    config = function()
      require "plugin_loader".configure "headwind"
    end}

  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.cmd "call mkdp#util#install()"
    end}

  -- Completion
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require "plugin_loader".configure "cmp"
    end}
  use "hrsh7th/cmp-vsnip"

  -- Snippets
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/vim-vsnip-integ"

  -- Lsp
  use "neovim/nvim-lspconfig"
  use {
    "williamboman/nvim-lsp-installer",
    config = function()
      require "plugin_loader".configure "lsp-installer"
    end}

  -- Productivity
  use {
    "kristijanhusak/orgmode.nvim",
    config = function()
      require "plugin_loader".configure "orgmode"
    end}

end)
