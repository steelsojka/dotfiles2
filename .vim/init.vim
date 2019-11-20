" Space is always the leader
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" --- Plugins --- {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'tpope/vim-projectionist'
Plug 'wfxr/forgit', { 'dir': '~/.forgit' }
Plug 'so-fancy/diff-so-fancy', { 'dir': '~/.diff-so-fancy' }
Plug 'norcalli/nvim.lua'

call plug#end()
" }}}
" --- Settings --- {{{
filetype plugin indent on
syntax on

set number
set termguicolors
set ruler
set undofile
set undodir=~/.vim/undo
set backup
set backupdir=~/.vim/backups
set shiftwidth=2
set tabstop=2
set expandtab 
set smartcase
set ignorecase
set scrolloff=5
set sidescrolloff=15
set hidden
set nowrap
set timeoutlen=500
set grepprg=rg\ --vimgrep\ --auto-hybrid-regex
set updatetime=200
set signcolumn=yes
set cmdheight=2
set mouse=nv
set noshowmode
set splitbelow
set splitright
set inccommand=nosplit
set shortmess+=c
set gdefault
set dictionary=/usr/share/dict/words
colorscheme OceanicNext

" Globally load all steelvim functions
lua require 'steelvim'
lua require('globals').initialize()

" }}}
" --- Plugin Setup --- {{{
" --- fzf --- {{{
" Show preview for files when searching
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('right:60%') : fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

" Search from current files directory
command! -bang -nargs=* DRg call steelvim#grep(<q-args>, expand('%:p:h'), <bang>0)
command! -bang -nargs=* Rg call steelvim#grep(<q-args>, getcwd(), <bang>0)

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Color fzf floating windows
highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#36353d

let g:fzf_action = {
\ 'ctrl-q': function('s:build_quickfix_list'),
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit' }
" }}}
" --- coc.nvim --- {{{
" let g:coc_node_path = $SYSTEM_NODE_PATH
" let g:coc_snippet_next = '<tab>'
inoremap <silent><expr> <C-SPACE> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

" Command to install all extensions
command! -nargs=0 InstallCocExtestions :CocInstall 
  \ coc-tsserver
  \ coc-json
  \ coc-git
  \ coc-java
  \ coc-pairs
  \ coc-prettier
  \ coc-css
  \ coc-html
  \ coc-yank
  \ coc-lists
  \ coc-snippets
  \ coc-eslint
  \ coc-angular
  \ coc-dictionary

"Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
 
" }}}
" --- lightline.vim  --- {{{
function! GetGitStatus() abort
  return luaeval('steelvim.get_git_status()')
endfunction
" }}}
" --- vim-sneak --- {{{
let g:sneak#label = 1
" }}}
" --- vim-caser --- {{{
let g:caser_prefix = '<Space>cc'
" }}}
" --- vim-startify --- {{{
let g:startify_custom_header = steelvim#get_startify_banner()
autocmd User Startified setlocal buflisted
" }}}
" --- vim-doge --- {{{
let g:doge_enable_mappings = 0
" }}}
" --- vim-floaterm --- {{{
let g:floaterm_winblend = 10
let g:floaterm_position = 'center'
let g:floaterm_background = '#36353d'
let g:floaterm_width = float2nr(&columns * 0.9)
let g:floaterm_height = float2nr(&lines * 0.75)

autocmd VimResized * let g:floaterm_width = float2nr(&columns * 0.9)
autocmd VimResized * let g:floaterm_height = float2nr(&lines * 0.75)
" }}}
" --- nvim-colorizer.lua --- {{{
lua << EOF
require('colorizer').setup {
  'css',
  'sass',
  'less',
  'typescript',
  'javascript',
  'vim',
  'html',
  'jst',
  'lua'
}
EOF
" }}}
" --- vim-polyglot --- {{{
let g:typescript_compiler_binary = 'node_modules/.bin/tsc'
let g:typescript_compiler_options = '--noEmit'
" }}}
" }}}

" --- Commands --- {{{
" Settings for terminal buffers
autocmd! TermOpen * setlocal nospell nonumber

" }}}
" --- Mappings --- {{{
lua require('global_mappings').initialize()
"}}}

" vim: set sw=2 ts=2 et foldlevel=1 foldmethod=marker:
