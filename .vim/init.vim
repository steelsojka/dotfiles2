call plug#begin('~/.local/share/nvim/plugged')

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!', 'WhichKeyVisual'] }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhartington/oceanic-next'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'

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
set noshowmode
set splitbelow
set splitright 
colorscheme OceanicNext

" ------------
" = Mappings =
" ------------

" Defines a leader key mapping and registers the description with WhichKey
function! DefineLeaderMapping(mode, keys, action, description, ...) abort
  let ignore_which_key = get(a:, 0, 0)

  execute a:mode . ' <leader>' . join(a:keys, '') . ' ' . a:action

  let category_keys = a:keys[:-2]
  let end_key = a:keys[-1:][0]
  let category = g:which_key_map

  if !ignore_which_key
    for key in category_keys
      let category = category[key]
    endfor

    let category[end_key] = a:description
  endif
endfunction

" Register mapping groupings
let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+files' }
let g:which_key_map.b = { 'name': '+buffers' }
let g:which_key_map.w = { 'name': '+windows' }
let g:which_key_map.w.r = { 'name': '+resize' }
let g:which_key_map.w.m = { 'name': '+move' }
let g:which_key_map.q = { 'name': '+quit' }
let g:which_key_map.s = { 'name': '+symbols' }
let g:which_key_map.y = { 'name': '+yank' }
let g:which_key_map.g = { 'name': '+git' }
let g:which_key_map.g.c = { 'name': '+chunk' }
let g:which_key_map.g.b = { 'name': '+branch' }
let g:which_key_map.g.l = { 'name': '+log' }
let g:which_key_map.g.r = { 'name': '+remote' }
let g:which_key_map.p = { 'name': '+project' }
let g:which_key_map.r = { 'name': '+refactor' }
let g:which_key_map.c = { 'name': '+comments' }
let g:which_key_map.e = { 'name': '+errors' }
let g:which_key_map.m = { 'name': '+marks' }
let g:which_key_map.j = { 'name': '+jump' }
let g:which_key_map.t = { 'name': '+terminal' }

" Load the mappings for WhichKey on demand
autocmd! User vim-which-key call which_key#register('<Space>', "g:which_key_map")

inoremap jj <esc>
tnoremap <esc> <C-\><C-n>
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <;lug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

call DefineLeaderMapping('nnoremap', ['<Space>'], ':', 'Ex Command', 1)
call DefineLeaderMapping('nnoremap', ['/'], ':History:<CR>', 'Search Command History')
" File mappings
call DefineLeaderMapping('nnoremap <silent>', ['f', 's'], ':w<CR>', 'Save File')
call DefineLeaderMapping('nnoremap <silent>', ['f', '/'], ':BLines<CR>', 'Search Lines')
call DefineLeaderMapping('nnoremap <silent>', ['f', 'f'], ':CocCommand prettier.formatFile<CR>', 'Format File')
call DefineLeaderMapping('nnoremap <silent>', ['f', 'o'], ':NERDTreeFind "expand(''%:p\'')"<CR>', 'Show in Tree')
call DefineLeaderMapping('nnoremap <silent>', ['f', 'r'], ':CocList mru<CR>', 'Open Recent Files')
" Buffer mappings
call DefineLeaderMapping('nnoremap <silent>', ['b', 'p'], ':bprevious<CR>', 'Previous Buffer')
call DefineLeaderMapping('nnoremap <silent>', ['b', 'n'], ':bnext<CR>', 'Next Buffer')
call DefineLeaderMapping('nnoremap <silent>', ['b', 'f'], ':bfirst<CR>', 'First Buffer')
call DefineLeaderMapping('nnoremap <silent>', ['b', 'l'], ':blast<CR>', 'Last Buffer')
call DefineLeaderMapping('nnoremap <silent>', ['b', 'd'], ':bp<CR>:bd#<CR>', 'Delete Buffer')
call DefineLeaderMapping('nnoremap <silent>', ['b', 'D'], ':bp<CR>:bw!#<CR>', 'Wipe Buffer')
call DefineLeaderMapping('nnoremap <silent>', ['b', 'k'], ':bw<CR>', 'Wipe Buffer')
call DefineLeaderMapping('nnoremap <silent>', ['b', 'b'], ':Buffers<CR>', 'List Buffers')
call DefineLeaderMapping('nnoremap <silent>', ['b', 'Y'], 'ggyG', 'Yank Buffer')
" Window mappings
call DefineLeaderMapping('nnoremap <silent>', ['w', 'w'], '<C-W>w', 'Move Below/Right')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'a'], ':Windows<CR>', 'List Windows')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'd'], '<C-W>c', 'Delete Window')
call DefineLeaderMapping('nnoremap <silent>', ['w', 's'], '<C-W>s', 'Split Window')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'v'], '<C-W>v', 'Split Window Vertical')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'n'], '<C-W>n', 'New Window')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'q'], '<C-W>q', 'Quit Window')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'j'], '<C-W>j', 'Move Down')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'k'], '<C-W>k', 'Move Up')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'h'], '<C-W>h', 'Move Left')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'l'], '<C-W>l', 'Move Right')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'm', 'r'], '<C-W>r', 'Rotate Right')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'm', 'R'], '<C-W>R', 'Rotate Left')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'm', 'j'], '<C-W>J', 'Move Window Down')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'm', 'k'], '<C-W>K', 'Move Window Up')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'm', 'h'], '<C-W>H', 'Move Window Left')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'm', 'l'], '<C-W>L', 'Move Window Right')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'm', 'x'], '<C-W>x', 'Swap Windows')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', 'j'], ':resize -5<CR>', 'Shrink')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', 'k'], ':resize +5<CR>', 'Grow')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', 'l'], ':vertical resize +5<CR>', 'Vertical Grow')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', 'h'], ':vertical resize -5<CR>', 'Vertical Shrink')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', 'J'], ':resize -20<CR>', 'Shrink Large')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', 'K'], ':resize +20<CR>', 'Grow Large')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', 'L'], ':vertical resize +20<CR>', 'Vertical Grow Large')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', 'H'], ':vertical resize -20<CR>', 'Vertical Shrink Large')
call DefineLeaderMapping('nnoremap <silent>', ['w', 'r', '='], '<C-W>=', 'Normalize Splits')
" Project mappings
call DefineLeaderMapping('nnoremap <silent>', ['p', 'f'], ':Files .<CR>', 'Find File')
call DefineLeaderMapping('nnoremap <silent>', ['p', 'F'], ':Files! .<CR>', 'Find File Fullscreen')
call DefineLeaderMapping('nnoremap', ['p', '/'], ':Rg!<Space>', 'Search Files')
call DefineLeaderMapping('nnoremap <silent>', ['p', 't'], ':NERDTreeToggle<CR>', 'Open File Explorer')
" Workspace mappings
call DefineLeaderMapping('nnoremap <silent>', ['q', 'q'], ':q<CR>', 'Quit')
call DefineLeaderMapping('nnoremap <silent>', ['q', 'Q'], ':q!<CR>', 'Force Quit')
" Navigation mappings
call DefineLeaderMapping('nnoremap <silent>', ['j', 'l'], '$', 'End of Line')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'h'], '0', 'Start of Line')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'k'], '<C-b>', 'Page Up')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'j'], '<C-f>', 'Page Down')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'd'], '<Plug>(coc-definition)', 'Definition')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'i'], '<Plug>(coc-implementation)', 'Implementation')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'y'], '<Plug>(coc-type-implementation)', 'Type Definition')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'r'], '<Plug>(coc-references)', 'Type References')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'e'], "'.", 'Last Edit')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'n'], "<C-o>", 'Next Jump')
call DefineLeaderMapping('nnoremap <silent>', ['j', 'p'], "<C-i>", 'Previous Jump')
" Symbol mappings
call DefineLeaderMapping('nnoremap <silent>', ['s', '/'], ':CocList symbols<CR>', 'Find Symbol')
call DefineLeaderMapping('nnoremap <silent>', ['s', 's'], ':CocAction<CR>', 'List Actions')
call DefineLeaderMapping('nnoremap <silent>', ['s', 'f'], ':CocList outline<CR>', 'List Symbols In File')
" Yank with preview
call DefineLeaderMapping('nnoremap <silent>', ['y', 'l'], ':<C-u>CocList -A --normal yank<CR>', 'List Yanks')
call DefineLeaderMapping('nnoremap <silent>', ['y', 'f'], ':let @" = expand("%:p")<CR>', 'Yank File Path')
call DefineLeaderMapping('nnoremap <silent>', ['y', 'y'], '"+y', 'Yank to Clipboard')
call DefineLeaderMapping('vnoremap <silent>', ['y', 'y'], '"+y', 'Yank to Clipboard', 1)
" Refactor mappings
call DefineLeaderMapping('nnoremap <silent>', ['r', 'n'], '<Plug>(coc-rename)', 'Rename')
" Comment mappings
call DefineLeaderMapping('nnoremap <silent>', ['c', 'l'], ':Commentary<CR>', 'Comment Line')
call DefineLeaderMapping('vnoremap', ['c', 'l'], ':Commentary<CR>', 'Comment Line', 1)
" Error mappings
call DefineLeaderMapping('nnoremap <silent>', ['e', 'l'], ':CocList diagnostics<CR>', 'List Errors')
" Mark mappings
call DefineLeaderMapping('nnoremap <silent>', ['m', 'l'], ':CocList marks<CR>', 'List Marks')
call DefineLeaderMapping('nnoremap', ['m', 'd'], ':delmarks<Space>', 'Delete Marks')
call DefineLeaderMapping('nnoremap', ['m', 'm'], '`', 'Go to Mark')
" Git mappings
call DefineLeaderMapping('nnoremap <silent>', ['g', 'c', 'u'], ':CocCommand git.chunkUndo<CR>', 'Undo Chunk')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'c', 's'], ':CocCommand git.chunkStage<CR>', 'Stage Chunk')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'b', 'l'], ':CocList branches<CR>', 'List Branches')
call DefineLeaderMapping('nnoremap <silent>', ['g', 's'], ':G<CR>', 'Git Status')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'd'], ':Gdiffsplit<CR>', 'Git Diff')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'e'], ':Gedit<CR>', 'Git Edit')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'a'], ':Gwrite<CR>', 'Git Add')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'g'], ':Git<Space>', 'Git Command')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'l', 'b'], ':Gblame<CR>', 'Git Blame')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'l', 'l'], ':Gllog<CR>', 'Git Log')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'l', 'c'], ':Gclog<CR>', 'Git Chunk Log')
call DefineLeaderMapping('vnoremap <silent>', ['g', 'l', 'c'], ':Gclog<CR>', 'Git Chunk Log', 1)
call DefineLeaderMapping('nnoremap <silent>', ['g', 'r', 'f'], ':Gfetch<CR>', 'Git Fetch')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'r', 'p'], ':Gpull<CR>', 'Git Pull')
call DefineLeaderMapping('nnoremap <silent>', ['g', 'r', 's'], ':Gpush<CR>', 'Git Push')
" Terminal mappings
call DefineLeaderMapping('nnoremap <silent>', ['t', 'n'], ':tabnew<CR>:term<CR>i', 'New Terminal Tab')
call DefineLeaderMapping('nnoremap <silent>', ['t', 'v'], ':vsp<CR>:term<CR>i', 'New Terminal Split')
call DefineLeaderMapping('nnoremap <silent>', ['t', 's'], ':sp<CR>:term<CR>i', 'New Terminal Vertical')
call DefineLeaderMapping('nnoremap <silent>', ['t', 'r'], ':vsp term://', 'Run in Terminal')

" Highlight jsonc comments
autocmd FileType json syntax match Comment +\/\/.\+$+

" -------------
" | Polyglot  |
" -------------
let g:polyglot_disabled = ['typescript']

" -------
" | FZF |
" -------

let $FZF_DEFAULT_COMMAND = 'rg --files'

" Show preview for files when searching
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" -------------
" | lightline |
" -------------

let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'git_status', 'readonly', 'filename', 'modified' ] ],
  \   'right': [[ 'lineinfo' ], ['percent']]
  \ },
  \ 'component_function': {
  \   'git_status': 'GetGitStatus'
  \ }
  \ }

" -------
" | COC |
" -------

let g:coc_node_path = $SYSTEM_NODE_PATH
let g:coc_snippet_next = '<tab>'
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
command! -nargs=0 InstallCocExtestions :CocInstall coc-tsserver coc-json coc-git coc-java coc-pairs coc-prettier coc-css coc-html coc-yank coc-project coc-prettier coc-lists coc-snippets

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

" Gets the git status branch for the status line
" If the window is not wide enough then nothing will be displayed.
function! GetGitStatus() abort
  let status = get(g:, 'coc_git_status', '')

  if winwidth(0) > 80
    return len(status) > 30 ? status[0:27] . '...' : status
  endif

  return ''
endfunction

