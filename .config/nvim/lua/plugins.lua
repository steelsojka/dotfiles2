local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone https://github.com/wbthomason/packer.nvim ".. install_path)
end

vim.cmd "packadd packer.nvim"

require "packer".startup(function()
  use {"wbthomason/packer.nvim", opt = true}
  use "liuchengxu/vim-which-key"
  use {
    "junegunn/fzf",
    run = function(conf)
      vim.cmd(string.format("!%s/install --all", conf.install_path))
      vim.cmd(string.format("!ln -s %s ~/.fzf", conf.install_path))
    end}
  use "junegunn/fzf.vim"
  use {"mhartington/oceanic-next", commit = "29d694b9f6323c90fb0f3f54239090370caa99fb"}
  use "tpope/vim-commentary"
  use "itchyny/lightline.vim"
  use "tpope/vim-fugitive"
  use {"mbbill/undotree", cmd = "UndotreeToggle"}
  use "tpope/vim-surround"
  use "justinmk/vim-dirvish"
  use "kristijanhusak/vim-dirvish-git"
  use "arthurxavierx/vim-caser"
  use "mhinz/vim-startify"
  use "norcalli/nvim-colorizer.lua"
  use "tpope/vim-dispatch"
  use {
    "so-fancy/diff-so-fancy",
    run = function(conf)
      vim.cmd(string.format("!ln -s %s/diff-so-fancy ~/bin/diff-so-fancy", conf.install_path))
    end}
  use {"hrsh7th/nvim-compe", commit = "96fafb56552953c8f1a139e9038b8ae970eafc29"}
  use "neovim/nvim-lspconfig"
  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"}}
  use "editorconfig/editorconfig-vim"
  use "sheerun/vim-polyglot"
  use "nvim-treesitter/playground"
  use "nvim-treesitter/nvim-treesitter-refactor"
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "~/src/nvim-tree-docs"
  use "nvim-treesitter/nvim-treesitter-angular"
  use "norcalli/snippets.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim"}}
  use "nvim-telescope/telescope-fzy-native.nvim"
  use "nvim-telescope/telescope-snippets.nvim"
  use {
    "jhawthorn/fzy",
    run = "PREFIX=$HOME make && PREFIX=$HOME make install"}
  use {
    "jpalardy/vim-slime",
    run = "npm install -g ts-node"}
  use {"Olical/aniseed", tag = "v3.12.0"}
  use "bakpakin/fennel.vim"
  use "mfussenegger/nvim-jdtls"
  use "mfussenegger/nvim-dap"
  use "diepm/vim-rest-console"
  use "phaazon/hop.nvim"
  use {
    "mhartington/formatter.nvim",
    run = function()
      vim.cmd "!npm install -g prettier"
      vim.cmd "!npm install -g eslint"
    end}
  use {
    "Olical/conjure",
    ft = {"fennel", "clojure"},
    tag = "v4.9.0"}
  use "tpope/vim-dadbod"
  use "steelsojka/pears.nvim"
  use "steelsojka/headwind.nvim"
end)
