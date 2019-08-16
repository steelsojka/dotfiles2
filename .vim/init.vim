call plug#begin('~/.local/share/nvim/plugged')

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/oceanic-next'
Plug 'sheerun/vim-polyglot'

call plug#end()

filetype plugin indent on
syntax on

" Space is always the leader
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" ------------
" = Settings =
" ------------

set number
set relativenumber
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
set timeoutlen=500
set grepprg=rg\ --vimgrep\ --auto-hybrid-regex
set updatetime=300
set signcolumn=yes
set cmdheight=2
colorscheme OceanicNext

" ------------
" = Mappings =
" ------------

inoremap jj <esc>
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" File mappings
nnoremap <leader>fs :w<CR>
nnoremap <leader>f/ :Lines<CR>
" Buffer mappings
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bk :bw<CR>
nnoremap <leader>bb :Buffers<CR>
" Window mappings
nnoremap <leader>ww <C-W>w
nnoremap <leader>wr <C-W>r
nnoremap <leader>wR <C-W>R
nnoremap <leader>wd <C-W>c
nnoremap <leader>wq <C-W>q
nnoremap <leader>wj <C-W>j
nnoremap <leader>wk <C-W>k
nnoremap <leader>wh <C-W>h
nnoremap <leader>wl <C-W>l
nnoremap <leader>wJ <C-W>J
nnoremap <leader>wK <C-W>K
nnoremap <leader>wH <C-W>H
nnoremap <leader>wL <C-W>L
nnoremap <leader>wx <C-W>x
" Project mappings
nnoremap <leader>pf :GFiles --exclude-standard --others --cached .<CR>
nnoremap <leader>pF :Files .<CR>
nnoremap <leader>p/ :Rg<Space>
nnoremap <leader>pt :Vexplore<CR>
" Workspace mappings
nnoremap <leader>qq :q<CR>
nnoremap <leader>qQ :q!<CR>
" Navigation mappings
nnoremap <leader>gl $
nnoremap <leader>gh 0
nnoremap <leader>gk <C-b>
nnoremap <leader>gj <C-f>
nnoremap <leader>gd <C-]>
" Symbol mappings
nnoremap <leader>s/ :CocList symbols<CR>
nnoremap <leader>ss :CocAction<CR>


" Highlight jsonc comments
autocmd FileType json syntax match Comment +\/\/.\+$+

" -------------
" | Polyglot  |
" -------------
let g:polyglot_disabled = ['typescript']

" -------------
" | Which Key |
" -------------
let g:which_key_map = {}

" -------
" | COC |
" -------

let g:coc_node_path = $SYSTEM_NODE_PATH
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

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Command to install all extensions
command! -nargs=0 InstallCocExtestions CocInstall coc-tsserver coc-json

" ---------
" | netrw |
" ---------

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25


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

