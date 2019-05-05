set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'gregsexton/MatchTag'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeFind'] }
Plug 'tpope/vim-abolish'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'groenewege/vim-less'
Plug 'plasticboy/vim-markdown'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'SirVer/ultisnips'
Plug 'nanotech/jellybeans.vim'
Plug 'digitaltoad/vim-jade'
Plug 'xolox/vim-session', { 'on': ['SaveSession', 'OpenSession']}
Plug 'xolox/vim-misc'
Plug 'benekastah/neomake'
"Plug 'Shougo/deoplete.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/neoyank.vim'
Plug 'neovim/node-host'
Plug 'steelsojka/vim-doc-it-for-me'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-expand-region'
Plug 'steelsojka/es.next.syntax.vim'
Plug 'othree/yajs.vim'
Plug 'steelsojka/deoplete-flow'
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()
filetype plugin indent on
syntax on

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

set number
set nowrap
set hlsearch
set incsearch
set smartcase
set ignorecase

set laststatus=2
set autoread
set undofile
set exrc
set secure
set tabstop=4
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set backspace=eol,start,indent
set showmatch
set showcmd
set ruler
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/tmp
set undodir=~/.vim/undo
set pastetoggle=<F2>
set grepprg=ag
set shiftround
set nofoldenable
set lazyredraw
set tags=.tags;

" ------------------------------------------------------------------------
" Completion
" ------------------------------------------------------------------------

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=node_modules/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=.cache/**
set wildignore+=.tmp/**
set wildignore+=.git/**

" ------------------------------------------------------------------------
" Scrolling
" ------------------------------------------------------------------------

set scrolloff=5       "Start scrolling when we're 5 lines away from
set sidescrolloff=15
set sidescroll=1

set timeoutlen=500
set ttimeout
set ttimeoutlen=1

" ------------------------------------------------------------------------
" Schemes
" ------------------------------------------------------------------------
colorscheme jellybeans

" ------------------------------------------------------------------------
" Mappings
" ------------------------------------------------------------------------

command! Q q
command! E e

" Fast quiting
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Remove search highlight
nnoremap <silent> ,/ :nohlsearch<CR>

" Fast saving
nnoremap <Leader>w :w<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-O>:w<CR>

nmap k gk
nmap j gj

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Paste from clipboard register
nnoremap <Leader>v "+p

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <tab> gt
nnoremap <s-tab> gT

nnoremap <s-l> g;
nnoremap <s-h> g,

nnoremap <S-Left> <C-w><
nnoremap <S-Down> <C-w>-
nnoremap <S-Up> <C-w>+
nnoremap <S-Right> <C-w>>

nnoremap <F3> :call HighlightCursor()<cr>
inoremap <F3> :call HighlightCursor()<cr>

" Moving lines
nnoremap <silent> ˚ :move-2<cr>
nnoremap <silent> ∆ :move+<cr>
nnoremap <silent> ˙ <<
nnoremap <silent> ¬ >>
xnoremap <silent> ˚ :move-2<cr>gv
xnoremap <silent> ∆ :move'>+<cr>gv
xnoremap <silent> ˙ <gv
xnoremap <silent> ¬ >gv
xnoremap < <gv
xnoremap > >gv

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Replace double quotes with single quotes
nnoremap <Leader>'' :%s/"/'/g<CR>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Escaping
inoremap jj <esc>

" If we forget to sudo
cmap w!! w !sudo tee % >/dev/null

" Type semicolon instead of Shift+colon
nnoremap ; :

" Replace highlighted text
vnoremap <C-r> "+y:%s/<C-r>+//g<left><left>

au BufRead,BufNewFile *.js set syntax=typescript
au BufRead,BufNewFile *.flow set syntax=typescript

" ------ Terminal mappings ------------

if has('nvim')
  nnoremap <leader>c :vsplit<cr>:term<cr>
  nnoremap <leader>hc :split<cr>:term<cr>
  " Exit terminal mode with ESC
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif 

" ------------------------------------------------------------------------
" unite.vim
" ------------------------------------------------------------------------

" CtrlP like behavour
nnoremap <S-p> :Unite file_rec/async -start-insert -auto-preview -direction=botright -winheight=15<cr>
nnoremap <C-p> :Unite file_rec/async -start-insert -direction=botright -winheight=15<cr>

if executable('ag') 
  let g:unite_source_rec_async_command=['ag', '--nocolor', '--nogroup', '--hidden', '-g', '']
endif

call unite#custom#source('file_rec/async', 'ignore_globs', split(&wildignore, ','))
call unite#custom#source('file_rec/async', 'max_candidates', 0)

" Ack Grep behavour
if executable('ag') 
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_default_opts = '--ignore .git -i --vimgrep'
endif
nnoremap <leader>/ :Unite -direction=botright grep:.<cr>

" YankRing behaviour
let g:unite_source_history_yank_enable = 1
nnoremap <leader>p :Unite history/yank -direction=botright -winheight=15<cr>

" Buffer Explorer behavour
nnoremap <leader>e :Unite -no-split -auto-preview -buffer-name=buffer -winheight=15 -direction=botright buffer<cr>

" Unite buffer overrides
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  imap <silent><buffer><expr> <C-h> unite#do_action('split')
  nmap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nmap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  nmap <silent><buffer><expr> <C-h> unite#do_action('split')
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

" ------------------------------------------------------------------------
" vim-airline
" ------------------------------------------------------------------------
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1

" ------------------------------------------------------------------------
" Neomake
" ------------------------------------------------------------------------
let g:neomake_javascript_enabled_makers = ['eslint', 'jscs']
autocmd! BufWritePost * Neomake

" ------------------------------------------------------------------------
" UndoTree
" ------------------------------------------------------------------------
nnoremap U :UndotreeToggle<CR>

" ------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------
nnoremap <leader>t :NERDTree<CR>
nnoremap <leader>f :NERDTreeFind<CR>
" let NERDTreeIgnore = []

" ------------------------------------------------------------------------
" vim-sessions
" ------------------------------------------------------------------------
let g:session_autoload='no'
let g:session_autosave='no'
nnoremap <Leader>os :OpenSession<CR>
nnoremap <Leader>ss :SaveSession 

" ------------------------------------------------------------------------
" vim-numbertoggle
" ------------------------------------------------------------------------
let g:UseNumberToggleTrigger = 0
nnoremap <Leader>n :call NumberToggle()<cr>

" ------------------------------------------------------------------------
" UltiSnips
" ------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDir="~/.vim/UltiSnips"

" ------------------------------------------------------------------------
" Deoplete.nvim
" ------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1

" ------------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------------
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
    	return 'PASTE MODE  '
  	en
    return ''
endfunction

let g:highlightCursorState = 0

function! HighlightCursor()
  if g:highlightCursorState == 0
    let g:highlightCursorState = 1
    set cursorline
    set cursorcolumn
    echo "Cursor highlight on"
  else 
    let g:highlightCursorState = 0
    set nocursorline
    set nocursorcolumn
    echo "Cursor highlight off"
  endif
endfunction

" ----------------------------------------------------------------------------
" SaveMacro / LoadMacro
" ----------------------------------------------------------------------------
function! s:save_macro(name, file)
  let content = eval('@'.a:name)
  if !empty(content)
    call writefile(split(content, "\n"), a:file)
    echom len(content) . " bytes save to ". a:file
  endif
endfunction
command! -nargs=* SaveMacro call <SID>save_macro(<f-args>)

function! s:load_macro(file, name)
  let data = join(readfile(a:file), "\n")
  call setreg(a:name, data, 'c')
  echom "Macro loaded to @". a:name
endfunction
command! -nargs=* LoadMacro call <SID>load_macro(<f-args>)
