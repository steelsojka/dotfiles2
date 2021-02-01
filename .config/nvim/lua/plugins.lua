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
  use "justinmk/vim-sneak"
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
      vim.cmd(string.format("!ln -s %s ~/.diff-so-fancy", conf.install_path))
    end}
  use "hrsh7th/nvim-compe"
  use "neovim/nvim-lspconfig"
  use "airblade/vim-gitgutter"
  use "editorconfig/editorconfig-vim"
  use "raimondi/delimitmate"
  use "sheerun/vim-polyglot"
  use "nvim-treesitter/playground"
  -- use "~/src/playground"
  use "nvim-treesitter/nvim-treesitter-refactor"
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "nvim-treesitter/nvim-tree-docs"
  -- use "~/src/nvim-tree-docs"
  use "nvim-treesitter/nvim-treesitter-angular"
  -- use "~/src/nvim-treesitter-angular"
  use "norcalli/snippets.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim"}}
  use "jpalardy/vim-slime"
  use {"Olical/aniseed", tag = "v3.12.0"}
  use "bakpakin/fennel.vim"
  use "mfussenegger/nvim-jdtls"
  use {
    "mhartington/formatter.nvim",
    run = function()
      vim.cmd "!npm install -g prettier"
    end}
  use {
    "Olical/conjure",
    ft = {"fennel", "clojure"},
    tag = "v4.9.0"}
end)
