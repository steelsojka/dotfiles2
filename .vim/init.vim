" Space is always the leader
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
filetype plugin indent on
syntax on

let g:polyglot_disabled = [
  \ 'typescript',
  \ 'html',
  \ 'lua',
  \ 'javascript',
  \ 'json',
  \ 'java',
  \ 'css',
  \ 'c'
  \]

" Install vim-plugged if not installed
if filereadable(glob('~/.local/share/nvim/site/autoload/plug.vim')) == 0
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'commit': '2115caeba1b55040bfdb1b8c38a836ad4e0b7669' }
Plug 'mhartington/oceanic-next'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-dirvish'
Plug 'arthurxavierx/vim-caser'
Plug 'mhinz/vim-startify'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tpope/vim-dispatch'
Plug 'so-fancy/diff-so-fancy', { 'dir': '~/.diff-so-fancy' }
Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'haorenW1025/diagnostic-nvim'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'dense-analysis/ale'
Plug 'steelsojka/completion-buffers'
Plug 'raimondi/delimitmate'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-tree-docs'
Plug 'norcalli/snippets.nvim'
Plug 'vigoux/architext.nvim'
Plug 'jpalardy/vim-slime'
Plug 'Olical/aniseed'
Plug 'Olical/conjure', {'tag': 'v4.5.0'}

call plug#end()

lua require "aniseed.env".init({ module = "dotfiles.init" })
