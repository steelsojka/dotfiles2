" Space is always the leader
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
filetype plugin indent on
syntax on

" Install vim-plugged if not installed
if filereadable(glob('~/.local/share/nvim/site/autoload/plug.vim')) == 0
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'
Plug 'sheerun/vim-polyglot'
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
Plug 'kkoomen/vim-doge'
Plug 'voldikss/vim-floaterm', { 'on': ['FloatermToggle'] }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tpope/vim-dispatch'
Plug 'wfxr/forgit', { 'dir': '~/.forgit' }
Plug 'so-fancy/diff-so-fancy', { 'dir': '~/.diff-so-fancy' }
Plug 'norcalli/nvim.lua', { 'commit': 'ceb76105a8d715eec898c692ba41c2d8dbdc6dbd' }
Plug 'haorenW1025/completion-nvim'
Plug 'neovim/nvim-lsp'
" Plug 'steelsojka/nvim-lsp', { 'branch': 'angular-ls' }
Plug 'haorenW1025/diagnostic-nvim'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
" TODO: Install UltiSnips
" Integrate FZF with LSP (symbols, diagnostics, etc...)

call plug#end()

lua require 'init'
