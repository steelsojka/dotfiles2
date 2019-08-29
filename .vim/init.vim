call plug#begin('~/.local/share/nvim/plugged')

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!', 'WhichKeyVisual'] }
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
colorscheme OceanicNext

" ------------
" = Mappings =
" ------------

" Register mapping groupings
let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+file' }
let g:which_key_map.b = { 'name': '+buffers' }
let g:which_key_map.w = { 'name': '+windows' }
let g:which_key_map.w.t = { 'name': '+tab' }
let g:which_key_map.w.b = { 'name': '+balance' }
let g:which_key_map.s = { 'name': '+search' }
let g:which_key_map.y = { 'name': '+yank' }
let g:which_key_map.g = { 'name': '+git' }
let g:which_key_map.g.c = { 'name': '+chunk' }
let g:which_key_map.g.b = { 'name': '+branch' }
let g:which_key_map.g.h = { 'name': '+history' }
let g:which_key_map.p = { 'name': '+project' }
let g:which_key_map.r = { 'name': '+refactor' }
let g:which_key_map.e = { 'name': '+errors' }
let g:which_key_map.c = { 'name': '+comments' }
let g:which_key_map.m = { 'name': '+marks' }
let g:which_key_map.j = { 'name': '+jump' }

" Load the mappings for WhichKey on demand
autocmd! User vim-which-key call which_key#register('<Space>', "g:which_key_map")
" Settings for terminal buffers
autocmd! TermOpen * setlocal nospell nonumber

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
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

call steelvim#define_leader_mapping('nnoremap', ["<Space>"], ':', 'Ex Command', 0)
call steelvim#define_leader_mapping('nnoremap', ['/'], ':History:<CR>', 'Search Command History')
" File mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 's'], ':w<CR>', 'Save File')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', '/'], ':BLines<CR>', 'Search Lines')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'f'], ':CocCommand prettier.formatFile<CR>', 'Format File')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'o'], ':Dirvish %:p:h<CR>', 'Show in Tree')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'O'], ':vsp +Dirvish\ %:p:h<CR>', 'Show in Split Tree')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'r'], ':CocList mru<CR>', 'Open Recent Files')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'u'], ':UndotreeToggle<CR>', 'Undo Tree')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'U'], ':UndotreeFocus<CR>', 'Focus Undo Tree')
" Buffer mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'p'], ':bprevious<CR>', 'Previous Buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'n'], ':bnext<CR>', 'Next Buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'f'], ':bfirst<CR>', 'First Buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'l'], ':blast<CR>', 'Last Buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'd'], ':bp<CR>:bd#<CR>', 'Delete Buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'D'], ':bp<CR>:bw!#<CR>', 'Wipe Buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'k'], ':bw<CR>', 'Wipe Buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'b'], ':Buffers<CR>', 'List Buffers')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'Y'], 'ggyG', 'Yank Buffer')
" Window mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'w'], '<C-W>w', 'Move Below/Right')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'a'], ':Windows<CR>', 'List Windows')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'd'], '<C-W>c', 'Delete Window')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 's'], '<C-W>s', 'Split Window')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'v'], '<C-W>v', 'Split Window Vertical')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'n'], '<C-W>n', 'New Window')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'q'], '<C-W>q', 'Quit Window')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'j'], '<C-W>j', 'Move Down')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'k'], '<C-W>k', 'Move Up')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'h'], '<C-W>h', 'Move Left')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'l'], '<C-W>l', 'Move Right')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'J'], '<C-W>J', 'Move Window Down')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'K'], '<C-W>K', 'Move Window Up')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'H'], '<C-W>H', 'Move Window Left')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'L'], '<C-W>L', 'Move Window Right')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'r'], '<C-W>r', 'Rotate Forward')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'R'], '<C-W>R', 'Rotate Backwards')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'j'], ':resize -5<CR>', 'Shrink')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'k'], ':resize +5<CR>', 'Grow')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'l'], ':vertical resize +5<CR>', 'Vertical Grow')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'h'], ':vertical resize -5<CR>', 'Vertical Shrink')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'J'], ':resize -20<CR>', 'Shrink Large')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'K'], ':resize +20<CR>', 'Grow Large')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'L'], ':vertical resize +20<CR>', 'Vertical Grow Large')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'H'], ':vertical resize -20<CR>', 'Vertical Shrink Large')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', '='], '<C-W>=', 'Balance Splits')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', '='], '<C-W>=', 'Balance Splits')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'F'], ':tabnew<CR>', 'New Tab')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'o'], ':tabnext<CR>', 'Next Tab')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', '/'], ':Windows<CR>', 'Search Windows')
" Project mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 'f'], ':Files .<CR>', 'Find File')
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 'F'], ':Files! .<CR>', 'Find File Fullscreen')
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 'T'], ':vsp +Dirvish<CR>', 'Open File Explorer in Split')
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 't'], ':Dirvish<CR>', 'Open File Explorer')
" Workspace mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['q'], ':q<CR>', 'Quit')
call steelvim#define_leader_mapping('nnoremap <silent>', ['Q'], ':q!<CR>', 'Force Quit')
" Navigation mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'l'], '$', 'End of Line')
call steelvim#define_leader_mapping('vnoremap <silent>', ['j', 'l'], '$', 'End of Line', 1)
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'h'], '0', 'Start of Line')
call steelvim#define_leader_mapping('vnoremap <silent>', ['j', 'h'], '0', 'Start of Line', 1)
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'k'], '<C-b>', 'Page Up')
call steelvim#define_leader_mapping('vnoremap <silent>', ['j', 'k'], '<C-b>', 'Page Up', 1)
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'j'], '<C-f>', 'Page Down')
call steelvim#define_leader_mapping('vnoremap <silent>', ['j', 'j'], '<C-f>', 'Page Down', 1)
call steelvim#define_leader_mapping('nmap <silent>', ['j', 'd'], '<Plug>(coc-definition)', 'Definition')
call steelvim#define_leader_mapping('nmap <silent>', ['j', 'i'], '<Plug>(coc-implementation)', 'Implementation')
call steelvim#define_leader_mapping('nmap <silent>', ['j', 'y'], '<Plug>(coc-type-implementation)', 'Type Definition')
call steelvim#define_leader_mapping('nmap <silent>', ['j', 'r'], '<Plug>(coc-references)', 'Type References')
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'e'], "'.", 'Last Edit')
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'n'], "<C-o>", 'Next Jump')
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'p'], "<C-i>", 'Previous Jump')
" Search mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['s', '/'], ':History/<CR>', 'Search History')
call steelvim#define_leader_mapping('nnoremap <silent>', ['s', 's'], ':CocList symbols<CR>', 'Find Symbol')
call steelvim#define_leader_mapping('nnoremap <silent>', ['s', 'l'], ':BLines<CR>', 'Search Buffer Lines')
call steelvim#define_leader_mapping('nnoremap <silent>', ['s', 'a'], ':CocAction<CR>', 'List Actions')
call steelvim#define_leader_mapping('nnoremap <silent>', ['s', 'o'], ':CocList outline<CR>', 'List Symbols In File')
call steelvim#define_leader_mapping('nnoremap <silent>', ['s', 'b'], ':Lines<CR>', 'Search Lines')
call steelvim#define_leader_mapping('nnoremap', ['s', 'p'], ':Rg!<Space>', 'Search Files in Project')
" Yank with preview
call steelvim#define_leader_mapping('nnoremap <silent>', ['y', 'l'], ':<C-u>CocList -A --normal yank<CR>', 'List Yanks')
call steelvim#define_leader_mapping('nnoremap <silent>', ['y', 'f'], ':let @" = expand("%:p")<CR>', 'Yank File Path')
call steelvim#define_leader_mapping('nnoremap <silent>', ['y', 'y'], '"+y', 'Yank to Clipboard')
call steelvim#define_leader_mapping('vnoremap <silent>', ['y', 'y'], '"+y', 'Yank to Clipboard', 1)
" Refactor mappings
call steelvim#define_leader_mapping('nmap <silent>', ['r', 'n'], '<Plug>(coc-rename)', 'Rename')
" Edit mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['c', 'l'], ':Commentary<CR>', 'Comment Line')
call steelvim#define_leader_mapping('vnoremap', ['c', 'l'], ':Commentary<CR>', 'Comment Line', 1)
" Diagnostics mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['e', 'l'], ':CocList diagnostics<CR>', 'List Diagnostics')
" Mark mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['m', 'l'], ':CocList marks<CR>', 'List Marks')
call steelvim#define_leader_mapping('nnoremap', ['m', 'd'], ':delmarks<Space>', 'Delete Marks')
call steelvim#define_leader_mapping('nnoremap', ['m', 'm'], '`', 'Go to Mark')
" Git mappings
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'c', 'u'], ':CocCommand git.chunkUndo<CR>', 'Undo Chunk')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'c', 's'], ':CocCommand git.chunkStage<CR>', 'Stage Chunk')
call steelvim#define_leader_mapping('nmap <silent>', ['g', 'c', 'n'], '<Plug>(coc-git-nextchunk)', 'Next Chunk')
call steelvim#define_leader_mapping('nmap <silent>', ['g', 'c', 'p'], '<Plug>(coc-git-prevchunk)', 'Previous Chunk')
call steelvim#define_leader_mapping('nmap <silent>', ['g', 'c', 'i'], '<Plug>(coc-git-chunkinfo)', 'Chunk Info')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'b', 'l'], ':CocList branches<CR>', 'List Branches')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 's'], ':G<CR>', 'Git Status')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'd'], ':Gdiffsplit<CR>', 'Git Diff')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'e'], ':Gedit<CR>', 'Git Edit')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'a'], ':Gwrite<CR>', 'Git Add')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'g'], ':Git<Space>', 'Git Command')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'l'], ':Gllog<CR>', 'Git Log')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'L'], ':Gclog<CR>', 'Git Chunk Log')
call steelvim#define_leader_mapping('vnoremap <silent>', ['g', 'L'], ':Gclog<CR>', 'Git Chunk Log', 1)
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'f'], ':Gfetch<CR>', 'Git Fetch')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'p'], ':Gpull<CR>', 'Git Pull')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'P'], ':Gpush<CR>', 'Git Push')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'h', 'c'], ':Commits<CR>', 'Commit History')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'h', 'C'], ':Commits<CR>', 'Buffer Commit History')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'h', 'b'], ':Gblame<CR>', 'Git Blame')

" -------------
" | sneak.vim |
" -------------
let g:sneak#label = 1

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
command! -nargs=0 InstallCocExtestions :CocInstall coc-tsserver coc-json coc-git coc-java coc-pairs coc-prettier coc-css coc-html coc-yank coc-project coc-lists coc-snippets coc-eslint

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

