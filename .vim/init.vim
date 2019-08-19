call plug#begin('~/.local/share/nvim/plugged')

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhartington/oceanic-next'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'HerringtonDarkholme/yats.vim'

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
set updatetime=300
set signcolumn=yes
set cmdheight=2
set mouse=nv
colorscheme OceanicNext

" ------------
" = Mappings =
" ------------

" Defines a leader key mapping and registers the description with WhichKey
function! DefineLeaderMapping(mode, keys, action, description) abort
  execute a:mode . ' <leader>' . join(a:keys, '') . ' ' . a:action
  let category_keys = a:keys[:-2]
  let end_key = a:keys[-1:][0]
  let category = g:which_key_map
  " Escape certain sequences for feedkeys
  let escaped_cmd = substitute(a:action, '<cr>', "\<cr>", 'g')
  let escaped_cmd = substitute(escaped_cmd, '<CR>', "\<CR>", 'g')
  let escaped_cmd = substitute(escaped_cmd, '<Esc>', "\<Esc>", 'g')
  let escaped_cmd = substitute(escaped_cmd, '<Plug>', "\<Plug>", 'g')

  for key in category_keys
    let category = category[key]
  endfor

  let category[end_key] = ['call feedkeys("' . escaped_cmd . '", "m")', a:description] 
endfunction

" Register mapping groupings
let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+files' }
let g:which_key_map.b = { 'name': '+buffers' }
let g:which_key_map.w = { 'name': '+windows' }
let g:which_key_map.q = { 'name': '+quit' }
let g:which_key_map.s = { 'name': '+symbols' }
let g:which_key_map.y = { 'name': '+yank' }
let g:which_key_map.g = { 'name': '+goto' }
let g:which_key_map.p = { 'name': '+project' }
let g:which_key_map.r = { 'name': '+refactor' }
let g:which_key_map.c = { 'name': '+comments' }

" Load the mappings for WhichKey on demand
autocmd! User vim-which-key call which_key#register('<Space>', "g:which_key_map")

inoremap jj <esc>
tnoremap jj <C-\><C-n>
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" File mappings
call DefineLeaderMapping('nnoremap', ['f', 's'], ':w<CR>', 'Save File')
call DefineLeaderMapping('nnoremap', ['f', '/'], ':Lines<CR>', 'Search Lines')
call DefineLeaderMapping('nnoremap', ['f', 'f'], ':CocCommand prettier.formatFile<CR>', 'Format File')
" Buffer mappings
call DefineLeaderMapping('nnoremap', ['b', 'p'], ':bprevious<CR>', 'Previous Buffer')
call DefineLeaderMapping('nnoremap', ['b', 'n'], ':bnext<CR>', 'Next Buffer')
call DefineLeaderMapping('nnoremap', ['b', 'f'], ':bfirst<CR>', 'First Buffer')
call DefineLeaderMapping('nnoremap', ['b', 'l'], ':blast<CR>', 'Last Buffer')
call DefineLeaderMapping('nnoremap', ['b', 'd'], ':bn<CR>:bd#<CR>', 'Delete Buffer')
call DefineLeaderMapping('nnoremap', ['b', 'k'], ':bw<CR>', 'Wipe Buffer')
call DefineLeaderMapping('nnoremap', ['b', 'b'], ':Buffers<CR>', 'List Buffers')
" Window mappings
call DefineLeaderMapping('nnoremap', ['w', 'w'], '<C-W>w', 'Move Below/Right')
call DefineLeaderMapping('nnoremap', ['w', 'r'], '<C-W>r', 'Rotate Window Right')
call DefineLeaderMapping('nnoremap', ['w', 'R'], '<C-W>R', 'Rotate Window Left')
call DefineLeaderMapping('nnoremap', ['w', 'd'], '<C-W>c', 'Delete Window')
call DefineLeaderMapping('nnoremap', ['w', 's'], '<C-W>s', 'Split Window')
call DefineLeaderMapping('nnoremap', ['w', 'v'], '<C-W>v', 'Split Window Vertical')
call DefineLeaderMapping('nnoremap', ['w', 'n'], '<C-W>n', 'New Window')
call DefineLeaderMapping('nnoremap', ['w', 'q'], '<C-W>q', 'Quit Window')
call DefineLeaderMapping('nnoremap', ['w', 'j'], '<C-W>j', 'Move Down')
call DefineLeaderMapping('nnoremap', ['w', 'k'], '<C-W>k', 'Move Up')
call DefineLeaderMapping('nnoremap', ['w', 'h'], '<C-W>h', 'Move Left')
call DefineLeaderMapping('nnoremap', ['w', 'l'], '<C-W>l', 'Move Right')
call DefineLeaderMapping('nnoremap', ['w', 'J'], '<C-W>J', 'Move Window Down')
call DefineLeaderMapping('nnoremap', ['w', 'K'], '<C-W>K', 'Move Window Up')
call DefineLeaderMapping('nnoremap', ['w', 'H'], '<C-W>H', 'Move Window Left')
call DefineLeaderMapping('nnoremap', ['w', 'L'], '<C-W>L', 'Move Window Right')
call DefineLeaderMapping('nnoremap', ['w', 'x'], '<C-W>x', 'Swap Windows')
" Project mappings
call DefineLeaderMapping('nnoremap', ['p', 'f'], ':GFiles --exclude-standard --others --cached .<CR>', 'Find File (Git)')
call DefineLeaderMapping('nnoremap', ['p', 'F'], ':Files .<CR>', 'Find File')
call DefineLeaderMapping('nnoremap', ['p', '/'], ':Rg<Space>', 'Search Files')
call DefineLeaderMapping('nnoremap', ['p', 't'], ':Vexplore<CR>', 'Open File Explorer')
" Workspace mappings
call DefineLeaderMapping('nnoremap', ['q', 'q'], ':q<CR>', 'Quit')
call DefineLeaderMapping('nnoremap', ['q', 'Q'], ':q!<CR>', 'Force Quit')
" Navigation mappings
call DefineLeaderMapping('nnoremap', ['g', 'l'], '$', 'End of Line')
call DefineLeaderMapping('nnoremap', ['g', 'h'], '0', 'Start of Line')
call DefineLeaderMapping('nnoremap', ['g', 'k'], '<C-b>', 'Page Up')
call DefineLeaderMapping('nnoremap', ['g', 'j'], '<C-f>', 'Page Down')
call DefineLeaderMapping('nmap <silent>', ['g', 'd'], '<Plug>(coc-definition)', 'Definition')
call DefineLeaderMapping('nmap <silent>', ['g', 'i'], '<Plug>(coc-implementation)', 'Implementation')
call DefineLeaderMapping('nmap <silent>', ['g', 'y'], '<Plug>(coc-type-implementation)', 'Type Definition')
call DefineLeaderMapping('nmap <silent>', ['g', 'r'], '<Plug>(coc-references)', 'Type References')
" Symbol mappings
call DefineLeaderMapping('nnoremap', ['s', '/'], ':CocList symbols<CR>', 'Find Symbol')
call DefineLeaderMapping('nnoremap', ['s', 's'], ':CocAction<CR>', 'List Actions')
call DefineLeaderMapping('nnoremap', ['s', 'f'], ':CocList outline<CR>', 'List Symbols In File')
" Yank with preview
call DefineLeaderMapping('nnoremap', ['y', 'y'], ':<C-u>CocList -A --normal yank<CR>', 'List Yanks')
" Refactor mappings
call DefineLeaderMapping('nmap <silent>', ['r', 'n'], '<Plug>(coc-rename)', 'Rename')
" Comment mappings
call DefineLeaderMapping('nnoremap', ['c', 'l'], ':Commentary<CR>', 'Comment Line')
vnoremap <leader>cl :Commentary<CR>

" Highlight jsonc comments
autocmd FileType json syntax match Comment +\/\/.\+$+

" -------------
" | Polyglot  |
" -------------
let g:polyglot_disabled = ['typescript']

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


" Command to install all extensions
command! -nargs=0 InstallCocExtestions :CocInstall coc-tsserver coc-json coc-git coc-java coc-pairs coc-prettier coc-css coc-html coc-yank coc-project coc-prettier

"Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

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


