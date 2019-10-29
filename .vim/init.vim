" Space is always the leader
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" --- Plugins --- {{{
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
Plug 'arthurxavierx/vim-caser'
Plug 'jpalardy/vim-slime'
Plug 'mhinz/vim-startify'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'kkoomen/vim-doge'
Plug 'voldikss/vim-floaterm', { 'on': ['FloatermToggle'] }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'

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

" }}}
" --- Plugin Setup --- {{{
" --- vim-which-key --- {{{
" Register mapping groupings
let g:which_key_map = {}
let g:which_key_map[' '] = 'Ex command'
let g:which_key_map.f = { 'name': '+file' }
let g:which_key_map.b = { 'name': '+buffers' }
let g:which_key_map.w = { 'name': '+windows' }
let g:which_key_map.w.b = { 'name': '+balance' }
let g:which_key_map['/'] = { 'name': '+search' }
let g:which_key_map.y = { 'name': '+yank' }
let g:which_key_map.g = { 'name': '+git' }
let g:which_key_map.g.c = { 'name': '+chunk' }
let g:which_key_map.g.h = { 'name': '+history' }
let g:which_key_map.p = { 'name': '+project' }
let g:which_key_map.c = { 'name': '+code' }
let g:which_key_map.m = { 'name': '+local' }
let g:which_key_map.d = { 'name': '+documentation' }
let g:which_key_map.c.c = {
  \ 'name': '+case',
  \ 'p': 'PascalCase',
  \ 'm': 'MixedCase',
  \ 'c': 'camelCase',
  \ 'u': 'UPPER CASE',
  \ 'U': 'UPPER CASE',
  \ 't': 'Title Case',
  \ 's': 'Sentence case',
  \ '_': 'snake_case',
  \ 'k': 'kebab-case',
  \ '-': 'dash-case',
  \ '<space>': 'space case',
  \ '.': 'dot.case'
  \ }
let g:which_key_map.j = { 'name': '+jump' }
let g:which_key_map.j.m = { 'name': '+marks' }

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>

if filereadable('~/.localvimrc')
  source '~/.localvimrc'
endif

" Load the mappings for WhichKey on demand
autocmd! User vim-which-key call which_key#register(g:mapleader, "g:which_key_map")
" }}}
" --- fzf --- {{{
" Show preview for files when searching
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('right:60%') : fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Color fzf floating windows
highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#36353d

let g:fzf_layout = { 'window': 'call steelvim#float_fzf()' }
let g:fzf_action = {
\ 'ctrl-q': function('s:build_quickfix_list'),
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit' }
" }}}
" --- coc.nvim --- {{{
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
" 
" }}}
" --- lightline.vim  --- {{{
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

" Gets the git status branch for the status line
" If the window is not wide enough then nothing will be displayed.
function! GetGitStatus() abort
  let status = fugitive#head()

  if winwidth(0) > 80
    return len(status) > 30 ? status[0:27] . '...' : status
  endif

  return ''
endfunction
" }}}
" --- vim-sneak --- {{{
let g:sneak#label = 1

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
" }}}
" --- vim-caser --- {{{
let g:caser_prefix = '<Space>cc'
" }}}
" --- vim-slime --- {{{
let g:slime_target = 'neovim'
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
require 'colorizer'.setup {
  'css';
  'sass';
  'less';
  'typescript';
  'javascript';
  'vim';
  'html';
  'jst';
}
EOF
" }}}
" --- vim-polyglot --- {{{
let g:typescript_compiler_binary = 'node_modules/.bin/tsc'
let g:typescript_compiler_options = '--noEmit'
" }}}
" --- vim-projectionist --- {{{
let s:base_dir = resolve(expand("<sfile>:p:h"))
let s:projections_json_path = s:base_dir . '/projections.json'
let s:projections_json = readfile(s:projections_json_path)
let g:projectionist_heuristics = projectionist#json_parse(s:projections_json)
" }}}
" }}}
" --- Commands --- {{{
" Settings for terminal buffers
autocmd! TermOpen * setlocal nospell nonumber

" Custom grep for opening the quick fix window after searching
command! -nargs=+ QuickGrep execute 'silent grep! <args>' | copen 20

" }}}
" --- Mappings --- {{{
" Non-leader mappings {{{
inoremap jj <esc>
tnoremap <C-j><C-j> <C-\><C-n>
nnoremap U <C-r>
nnoremap ; :
vnoremap ; :
nnoremap / /\v
nnoremap ? ?\v
"}}}
" Generic mappings <leader> {{{
call steelvim#define_leader_mapping('nnoremap', ["<Space>"], ':Commands<CR>^', 'List Commands', 0)
call steelvim#define_leader_mapping('nnoremap', ['.'], ':Files<CR>', 'Find files')
call steelvim#define_leader_mapping('nnoremap', [','], ':Buffers<CR>', 'Switch buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['t'], ':call steelvim#float_term(0)<CR>', 'Float terminal')
call steelvim#define_leader_mapping('nnoremap <silent>', ['T'], ':call steelvim#float_term(1)<CR>', 'Float terminal (full)')
" }}}
" File mappings <leader>f {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 's'], ':w<CR>', 'Save file')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'S'], ':wa<CR>', 'Save all files')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', '/'], ':BLines<CR>', 'Search lines')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'f'], ':call CocAction("format")<CR>', 'Format file')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'o'], ':Dirvish %:p:h<CR>', 'Show in tree')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'O'], ':vsp +Dirvish\ %:p:h<CR>', 'Show in split tree')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'r'], ':CocList mru<CR>', 'Open recent files')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'u'], ':UndotreeToggle<CR>', 'Undo tree')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'U'], ':UndotreeFocus<CR>', 'Focus undo tree')
call steelvim#define_leader_mapping('nnoremap <silent>', ['f', 'E'], ':vsp $MYVIMRC<CR>', 'Edit .vimrc')
" }}}
" Buffer mappings <leader>b {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'p'], ':bprevious<CR>', 'Previous buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'n'], ':bnext<CR>', 'Next buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'f'], ':bfirst<CR>', 'First buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'l'], ':blast<CR>', 'Last buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'd'], ':bp<CR>:bd#<CR>', 'Delete buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'k'], ':bp<CR>:bw!#<CR>', 'Wipe buffer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'b'], ':Buffers<CR>', 'List buffers')
call steelvim#define_leader_mapping('nnoremap <silent>', ['b', 'Y'], 'ggyG', 'Yank buffer')
" }}}
" Window mappings <leader>w {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'w'], '<C-W>w', 'Move below/right')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'a'], ':Windows<CR>', 'List windows')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'd'], '<C-W>c', 'Delete window')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 's'], '<C-W>s', 'Split window')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'v'], '<C-W>v', 'Split window vertical')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'n'], '<C-W>n', 'New window')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'q'], '<C-W>q', 'Quit window')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'j'], '<C-W>j', 'Move down')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'k'], '<C-W>k', 'Move up')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'h'], '<C-W>h', 'Move left')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'l'], '<C-W>l', 'Move right')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'J'], '<C-W>J', 'Move window down')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'K'], '<C-W>K', 'Move window up')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'H'], '<C-W>H', 'Move window left')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'L'], '<C-W>L', 'Move window right')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'r'], '<C-W>r', 'Rotate forward')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'R'], '<C-W>R', 'Rotate backwards')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'j'], ':resize -5<CR>', 'Shrink')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'k'], ':resize +5<CR>', 'Grow')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'l'], ':vertical resize +5<CR>', 'Vertical grow')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'h'], ':vertical resize -5<CR>', 'Vertical shrink')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'J'], ':resize -20<CR>', 'Shrink large')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'K'], ':resize +20<CR>', 'Grow large')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'L'], ':vertical resize +20<CR>', 'Vertical grow large')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', 'H'], ':vertical resize -20<CR>', 'Vertical shrink large')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'b', '='], '<C-W>=', 'Balance splits')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', '='], '<C-W>=', 'Balance splits')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'F'], ':tabnew<CR>', 'New tab')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', 'o'], ':tabnext<CR>', 'Next tab')
call steelvim#define_leader_mapping('nnoremap <silent>', ['w', '/'], ':Windows<CR>', 'Search windows')
" }}}
" Project mappings <leader>p {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 'f'], ':Files .<CR>', 'Find file')
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 'F'], ':Files! .<CR>', 'Find file fullscreen')
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 'T'], ':vsp +Dirvish<CR>', 'Open File explorer in split')
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 't'], ':Dirvish<CR>', 'Open file Explorer')
call steelvim#define_leader_mapping('nnoremap <silent>', ['p', 'q'], ':qall<CR>', 'Quit project')
" }}}
" Workspace mappings <leader>q {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['q'], ':q<CR>', 'Quit')
call steelvim#define_leader_mapping('nnoremap <silent>', ['Q'], ':q!<CR>', 'Force quit')
" }}}
" Navigation mappings <leader>j {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'l'], '$', 'End of line')
call steelvim#define_leader_mapping('vnoremap <silent>', ['j', 'l'], '$', 'End of line', 1)
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'h'], '0', 'Start of line')
call steelvim#define_leader_mapping('vnoremap <silent>', ['j', 'h'], '0', 'Start of line', 1)
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'k'], '<C-b>', 'Page up')
call steelvim#define_leader_mapping('vnoremap <silent>', ['j', 'k'], '<C-b>', 'Page up', 1)
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'j'], '<C-f>', 'Page down')
call steelvim#define_leader_mapping('vnoremap <silent>', ['j', 'j'], '<C-f>', 'Page down', 1)
call steelvim#define_leader_mapping('nmap <silent>', ['j', 'd'], '<Plug>(coc-definition)', 'Definition')
call steelvim#define_leader_mapping('nmap <silent>', ['j', 'i'], '<Plug>(coc-implementation)', 'Implementation')
call steelvim#define_leader_mapping('nmap <silent>', ['j', 'y'], '<Plug>(coc-type-implementation)', 'Type definition')
call steelvim#define_leader_mapping('nmap <silent>', ['j', 'r'], '<Plug>(coc-references)', 'Type references')
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'e'], "'.", 'Last edit')
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'n'], "<C-o>", 'Next jump')
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'p'], "<C-i>", 'Previous jump')
call steelvim#define_leader_mapping('nnoremap <silent>', ['j', 'm', 'l'], ':CocList marks<CR>', 'List marks')
call steelvim#define_leader_mapping('nnoremap', ['j', 'm', 'd'], ':delmarks<Space>', 'Delete marks')
call steelvim#define_leader_mapping('nnoremap', ['j', 'm', 'm'], '`', 'Go to mark')
call steelvim#define_leader_mapping('nnoremap', ['j', 't'], ':A<CR>', 'Go to altenate')
call steelvim#define_leader_mapping('nnoremap', ['j', 'T'], ':AV<CR>', 'Split altenate')
" }}}
" Search mappings <leader>/ {{{
call steelvim#define_leader_mapping('nnoremap', ['/', 'd'], ':QuickGrep<Space> "%:p:h"<left><left><left><left><left><left><left><left>', 'Search directory')
call steelvim#define_leader_mapping('nnoremap <silent>', ['/', 'c'], ':History:<CR>', 'Search command history')
call steelvim#define_leader_mapping('nnoremap <silent>', ['/', '/'], ':History/<CR>', 'Search history')
call steelvim#define_leader_mapping('nnoremap <silent>', ['/', 'i'], ':CocList symbols<CR>', 'Search symbol')
call steelvim#define_leader_mapping('nnoremap <silent>', ['/', 'l'], ':BLines<CR>', 'Search buffer lines')
call steelvim#define_leader_mapping('nnoremap <silent>', ['/', 'o'], ':CocList outline<CR>', 'List symbols in file')
call steelvim#define_leader_mapping('nnoremap <silent>', ['/', 'b'], ':Lines<CR>', 'Search lines')
call steelvim#define_leader_mapping('nnoremap', ['/', 'p'], ':Rg<space>', 'Grep files in project')
call steelvim#define_leader_mapping('nnoremap', ['/', 'P'], ':Rg!<space>', 'Grep files in project (full)')
call steelvim#define_leader_mapping('nnoremap', ['/', 'h'], ':noh<CR>', 'Clear searh highlight')
call steelvim#define_leader_mapping('nnoremap', ['/', 's'], 'g*N', 'Search selected text')
call steelvim#define_leader_mapping('vnoremap', ['/', 's'], '"9y/<C-r>9<CR>', 'Search selected text', 1)
call steelvim#define_leader_mapping('nnoremap', ['/', 'S'], ':Rg <C-r><C-w><CR>', 'Search selected text (project)')
call steelvim#define_leader_mapping('vnoremap', ['/', 'S'], '"9y:Rg <C-r>9<CR>', 'Search selected text (project)', 1)
" }}}
" Yank with preview <leader>y {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['y', 'l'], ':<C-u>CocList -A --normal yank<CR>', 'List yanks')
call steelvim#define_leader_mapping('nnoremap <silent>', ['y', 'f'], ':let @" = expand("%:p")<CR>', 'Yank file path')
call steelvim#define_leader_mapping('nnoremap <silent>', ['y', 'F'], ':let @" = expand("%:t:r")<CR>', 'Yank file name')
call steelvim#define_leader_mapping('nnoremap <silent>', ['y', 'y'], '"+y', 'Yank to clipboard')
call steelvim#define_leader_mapping('vnoremap <silent>', ['y', 'y'], '"+y', 'Yank to clipboard', 1)
" }}}
" Code mappings <leader>c {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['c', 'l'], ':Commentary<CR>', 'Comment line')
call steelvim#define_leader_mapping('vnoremap', ['c', 'l'], ':Commentary<CR>', 'Comment line', 1)
call steelvim#define_leader_mapping('nnoremap <silent>', ['c', 'x'], ':CocList diagnostics<CR>', 'List diagnostics')
call steelvim#define_leader_mapping('nmap <silent>', ['c', 'd'], '<Plug>(coc-definition)', 'Definition')
call steelvim#define_leader_mapping('nmap <silent>', ['c', 'D'], '<Plug>(coc-references)', 'Type references')
call steelvim#define_leader_mapping('nmap <silent>', ['c', 'k'], "gh", 'Jump to documenation')
call steelvim#define_leader_mapping('nmap <silent>', ['c', 'r'], '<Plug>(coc-rename)', 'Rename symbol')
call steelvim#define_leader_mapping('nnoremap <silent>', ['c', 'f'], ':CocAction<CR>', 'Quick fix actions')
" }}}
" Documentation mappings <leader>d {{{
call steelvim#define_leader_mapping('nmap <silent>', ['d', 'd'], '<Plug>(doge-generate)', 'Document')
" }}}
" Git mappings <leader>g {{{
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'c', 'u'], ':CocCommand git.chunkUndo<CR>', 'Undo chunk')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'c', 's'], ':CocCommand git.chunkStage<CR>', 'Stage chunk')
call steelvim#define_leader_mapping('nmap <silent>', ['g', 'c', 'n'], '<Plug>(coc-git-nextchunk)', 'Next chunk')
call steelvim#define_leader_mapping('nmap <silent>', ['g', 'c', 'p'], '<Plug>(coc-git-prevchunk)', 'Previous chunk')
call steelvim#define_leader_mapping('nmap <silent>', ['g', 'c', 'i'], '<Plug>(coc-git-chunkinfo)', 'Chunk info')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'b'], ':call steelvim#checkout_git_branch_fzf(expand("%:p:h"))<CR>', 'Checkout branch')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 's'], ':G<CR>', 'Git status')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'd'], ':Gdiffsplit<CR>', 'Git diff')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'e'], ':Gedit<CR>', 'Git edit')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'a'], ':Gwrite<CR>', 'Git add')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'g'], ':Git<Space>', 'Git command')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'l'], ':Glog<CR>', 'Git log')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'L'], ':Glog -- %<CR>', 'Git file log')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'f'], ':Gfetch<CR>', 'Git fetch')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'p'], ':Gpull<CR>', 'Git pull')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'P'], ':Gpush<CR>', 'Git push')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'h', 'c'], ':Commits!<CR>', 'Commit history')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'h', 'f'], ':BCommits!<CR>', 'Buffer commit history')
call steelvim#define_leader_mapping('nnoremap <silent>', ['g', 'h', 'b'], ':Gblame<CR>', 'Git blame')
" }}}
" }}}

" vim: set sw=2 ts=2 et foldlevel=1 foldmethod=marker:
