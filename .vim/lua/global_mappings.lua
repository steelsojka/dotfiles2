local nvim = require 'nvim'
local mapping_utils = require 'mappings'
local fzf_diagnostics = require 'fzf/diagnostics'
local fzf_quickfix = require 'fzf/quickfix'

local mappings = {
  ['n '] = { function() steelvim.start_which_key(false) end, silent = true },
  ['v '] = { function() steelvim.start_which_key(true) end, silent = true },
  ['ijj'] = { [[<esc>]], description = 'Exit insert mode' },
  ['t<C-j><C-j>'] = { [[<C-\><C-n>]], description = 'Exit terminal mode' },
  ['nU'] = { [[<C-r>]], description = 'Redo' },
  ['n/'] = { [[/\v]], description = 'Search with magic' },
  ['n?'] = { [[?\v]], description = 'Search backwards with magic' },
  ['nK'] = { function() steelvim.show_documentation() end, description = 'Show documentation', silent = true },
  ['ngh'] = { function() steelvim.show_documentation() end, description = 'Show documentation', silent = true },
  -- Completion for all lines in all buffers
  ['i<C-l>'] = { [[<Plug>(fzf-complete-line)]], noremap = false },
  ['i<C-e>'] = { [[<Plug>(fzf-complete-path)]], noremap = false },
  ['i<C-w>'] = { [[<Plug>(fzf-complete-word)]], noremap = false },
  ['ngd'] = { [[<Plug>(coc-definition)]], noremap = false, silent = true },
  ['ngy'] = { [[<Plug>(coc-type-definition)]], noremap = false, silent = true },
  ['ngi'] = { [[<Plug>(coc-implementation)]], noremap = false, silent = true },
  ['ngr'] = { [[<Plug>(coc-references)]], noremap = false, silent = true },
  ['nf'] = { [[<Plug>Sneak_f]], noremap = false },
  ['nF'] = { [[<Plug>Sneak_F]], noremap = false },
  ['xf'] = { [[<Plug>Sneak_f]], noremap = false },
  ['xF'] = { [[<Plug>Sneak_F]], noremap = false },
  ['of'] = { [[<Plug>Sneak_f]], noremap = false },
  ['oF'] = { [[<Plug>Sneak_F]], noremap = false },
  ['nt'] = { [[<Plug>Sneak_t]], noremap = false },
  ['nT'] = { [[<Plug>Sneak_T]], noremap = false },
  ['xt'] = { [[<Plug>Sneak_t]], noremap = false },
  ['xT'] = { [[<Plug>Sneak_T]], noremap = false },
  ['ot'] = { [[<Plug>Sneak_t]], noremap = false },
  ['oT'] = { [[<Plug>Sneak_T]], noremap = false },
  ['n ,'] = { [[<Cmd>Buffers<CR>]], description = 'Switch buffer' },
  ['n .'] = { [[<Cmd>Files<CR>]], description = 'Find files' },
  ['n  '] = { [[<Cmd>Commands<CR>^]] },
  ['v  '] = { [[<Cmd>Commands<CR>^]] },
  -- File mappings <leader>f
  ['n fs'] = { [[<Cmd>w<CR>]], description = 'Save file' },
  ['n fS'] = { [[<Cmd>wa<CR>]], description = 'Save all files' },
  ['n f/'] = { [[<Cmd>BLines<CR>]], description = 'Search lines' },
  ['n ff'] = { [[<Cmd>call CocAction("format")<CR>]], description = 'Format file' },
  ['n fo'] = { [[<Cmd>Dirvish %:p:h<CR>]], description = 'Show in tree' },
  ['n fO'] = { [[<Cmd>vsp +Dirvish %:p:h<CR>]], description = 'Show in split tree' },
  ['n fr'] = { [[<Cmd>CocList mru<CR>]], description = 'Open recent files' },
  ['n fu'] = { [[<Cmd>UndotreeToggle<CR>]], description = 'Undo tree' },
  ['n fU'] = { [[<Cmd>UndotreeFocus<CR>]], description = 'Focus undo tree' },
  ['n fE'] = { [[<Cmd>vsp $MYVIMRC<CR>]], description = 'Edit .vimrc' },
  ['n fF'] = { [[<Cmd>Files %:p:h<CR>]], description = 'Find from file' },
  ['n fx'] = { function() fzf_diagnostics.open_diagnostics(true) end, description = 'List file diagnostics' },
  -- Buffer mappings <leader>b
  ['n bp'] = { [[<Cmd>bprevious<CR>]], description = 'Previous buffer' },
  ['n bn'] = { [[<Cmd>bnext<CR>]], description = 'Next buffer' },
  ['n bf'] = { [[<Cmd>bfirst<CR>]], description = 'First buffer' },
  ['n bl'] = { [[<Cmd>blast<CR>]], description = 'Last buffer' },
  ['n bd'] = { [[<Cmd>bp<CR>:bd#<CR>]], description = 'Delete buffer' },
  ['n bk'] = { [[<Cmd>bp<CR>:bw!#<CR>]], description = 'Wipe buffer' },
  ['n bb'] = { [[<Cmd>Buffers<CR>]], description = 'List buffers' },
  ['n bY'] = { [[ggyG]], description = 'Yank buffer' },
  -- Window mappings <leader>w
  ['n ww'] = { [[<C-W>w]], description = 'Move below/right' },
  ['n wa'] = { [[<Cmd>Windows<CR>]], description = 'List windows' },
  ['n wd'] = { [[<C-W>c]], description = 'Delete window' },
  ['n ws'] = { [[<C-W>s]], description = 'Split window' },
  ['n wv'] = { [[<C-W>v]], description = 'Split window vertical' },
  ['n wn'] = { [[<C-W>n]], description = 'New window' },
  ['n wq'] = { [[<C-W>q]], description = 'Quit window' },
  ['n wj'] = { [[<C-W>j]], description = 'Move down' },
  ['n wk'] = { [[<C-W>k]], description = 'Move up' },
  ['n wh'] = { [[<C-W>h]], description = 'Move left' },
  ['n wl'] = { [[<C-W>l]], description = 'Move right' },
  ['n wJ'] = { [[<C-W>J]], description = 'Move window down' },
  ['n wK'] = { [[<C-W>K]], description = 'Move window up' },
  ['n wH'] = { [[<C-W>H]], description = 'Move window left' },
  ['n wL'] = { [[<C-W>L]], description = 'Move window right' },
  ['n wr'] = { [[<C-W>r]], description = 'Rotate forward' },
  ['n wR'] = { [[<C-W>R]], description = 'Rotate backwards' },
  ['n wbj'] = { [[<Cmd>resize -5<CR>]], description = 'Shrink' },
  ['n wbk'] = { [[<Cmd>resize +5<CR>]], description = 'Grow' },
  ['n wbl'] = { [[<Cmd>vertical resize +5<CR>]], description = 'Vertical grow' },
  ['n wbh'] = { [[<Cmd>vertical resize -5<CR>]], description = 'Vertical shrink' },
  ['n wbJ'] = { [[<Cmd>resize -20<CR>]], description = 'Shrink large' },
  ['n wbK'] = { [[<Cmd>resize +20<CR>]], description = 'Grow large' },
  ['n wbL'] = { [[<Cmd>vertical resize +20<CR>]], description = 'Vertical grow large' },
  ['n wbH'] = { [[<Cmd>vertical resize -20<CR>]], description = 'Vertical shrink large' },
  ['n wb='] = { [[<C-W>=]], description = 'Balance splits' },
  ['n w='] = { [[<C-W>=]], description = 'Balance splits' },
  ['n wF'] = { [[<Cmd>tabnew<CR>]], description = 'New tab' },
  ['n wo'] = { [[<Cmd>tabnext<CR>]], description = 'Next tab' },
  ['n w/'] = { [[<Cmd>Windows<CR>]], description = 'Search windows' },
  ['n wS'] = { [[<Cmd>Startify<CR>]], description = 'Start screen' },
  -- Project mappings <leader>p
  ['n pf'] = { [[<Cmd>Files .<CR>]], description = 'Find file' },
  ['n pF'] = { [[<Cmd>Files! .<CR>]], description = 'Find file fullscreen' },
  ['n pT'] = { [[<Cmd>vsp +Dirvish<CR>]], description = 'Open File explorer in split' },
  ['n pt'] = { [[<Cmd>Dirvish<CR>]], description = 'Open file Explorer' },
  ['n pq'] = { [[<Cmd>qall<CR>]], description = 'Quit project' },
  -- Workspace mappings <leader>q
  ['n q'] = { [[<Cmd>q<CR>]], description = 'Quit' },
  ['n Q'] = { [[<Cmd>q!<CR>]], description = 'Force quit' },
  -- Navigation mappings <leader>j
  ['n jl'] = { [[$]], description = 'End of line' },
  ['v jl'] = { [[$]], description = 'End of line', which_key = false },
  ['n jh'] = { [[0]], description = 'Start of line' },
  ['v jh'] = { [[0]], description = 'Start of line', which_key = false },
  ['n jk'] = { [[<C-b>]], description = 'Page up' },
  ['v jk'] = { [[<C-b>]], description = 'Page up', which_key = false },
  ['n jj'] = { [[<C-f>]], description = 'Page down' },
  ['v jj'] = { [[<C-f>]], description = 'Page down', which_key = false },
  ['n jd'] = { [[<Plug>(coc-definition)]], description = 'Definition', noremap = false },
  ['n ji'] = { [[<Plug>(coc-implementation)]], description = 'Implementation', noremap = false },
  ['n jy'] = { [[<Plug>(coc-type-implementation)]], description = 'Type definition', noremap = false },
  ['n jr'] = { [[<Plug>(coc-references)]], description = 'Type references', noremap = false },
  ['n jep'] = { [[<Plug>(coc-diagnostics-prev)]], description = 'Previous error' },
  ['n jen'] = { [[<Plug>(coc-diagnostics-next)]], description = 'Next error' },
  ['n jn'] = { [[<C-o>]], description = 'Next jump' },
  ['n jp'] = { [[<C-i>]], description = 'Previous jump' },
  ['n jml'] = { [[<Cmd>CocList marks<CR>]], description = 'List marks' },
  ['n jmd'] = { [[<Cmd>delmarks<Space>]], description = 'Delete marks' },
  ['n jmm'] = { [[`]], description = 'Go to mark' },
  ['n ja'] = { [[<Cmd>A<CR>]], description = 'Go to altenate' },
  ['n jA'] = { [[<Cmd>AV<CR>]], description = 'Split altenate' },
  ['n jcn'] = { [[g,]], description = 'Next change' },
  ['n jcp'] = { [[g;]], description = 'Previous change' },
  -- Search mappings <leader>/
  ['n /d'] = { [[<Cmd>FlyDRg<CR>]], description = 'Grep files in directory' },
  ['n /c'] = { [[<Cmd>History:<CR>]], description = 'Search command history' },
  ['n //'] = { [[<Cmd>History/<CR>]], description = 'Search history' },
  ['n /i'] = { [[<Cmd>CocList symbols<CR>]], description = 'Search symbol' },
  ['n /l'] = { [[<Cmd>BLines<CR>]], description = 'Search buffer lines' },
  ['n /o'] = { [[<Cmd>CocList outline<CR>]], description = 'List symbols in file' },
  ['n /b'] = { [[<Cmd>Lines<CR>]], description = 'Search lines' },
  ['n /p'] = { [[<Cmd>FlyRg<CR>]], description = 'Grep files in project' },
  ['n /P'] = { [[<Cmd>FlyRg!<CR>]], description = 'Grep files in project (full),' },
  ['n /h'] = { [[<Cmd>noh<CR>]], description = 'Clear searh highlight' },
  ['n /s'] = { [[g*N]], description = 'Search selected text' },
  ['v /s'] = { [["9y/<C-r>9<CR>]] },
  ['n /S'] = { [[:Rg <C-r><C-w><CR>]], description = 'Search selected text (project)' },
  ['v /S'] = { [["9y:Rg <C-r>9<CR>]] },
  -- Yank with preview <leader>y
  ['n yl'] = { [[<Cmd>CocList -A --normal yank<CR>]], description = 'List yanks' },
  ['n yf'] = { [[<Cmd>let @" = expand("%:p")<CR>]], description = 'Yank file path' },
  ['n yF'] = { [[<Cmd>let @" = expand("%:t:r")<CR>]], description = 'Yank file name' },
  ['n yy'] = { [["+y]], description = 'Yank to clipboard' },
  ['v yy'] = { [["+y]] },
  -- Code mappings <leader>c
  ['n cl'] = { [[<Cmd>Commentary<CR>]], description = 'Comment line' },
  ['v cl'] = { [[:Commentary<CR>]] },
  ['n cx'] = { function() fzf_diagnostics.open_diagnostics() end, description = 'List diagnostics (Fzf)' },
  ['n cX'] = { [[<Cmd>CocList diagnostics<CR>]], description = 'List diagnostics (Coc)' },
  ['n cd'] = { [[<Plug>(coc-definition)]], description = 'Definition', noremap = false },
  ['n cD'] = { [[<Plug>(coc-references)]], description = 'Type references', noremap = false },
  ['n ck'] = { [[gh]], description = 'Jump to documenation', noremap = false },
  ['n cr'] = { [[<Plug>(coc-rename)]], description = 'Rename symbol', noremap = false },
  ['n cf'] = { [[<Cmd>CocAction<CR>]], description = 'Quick fix actions' },
  -- Documentation mappings <leader>d
  ['n dd'] = { [[<Plug>(doge-generate)]], description = 'Document', noremap = false },
  -- Git mappings <leader>g
  ['n gcu'] = { [[<Cmd>CocCommand git.chunkUndo<CR>]], description = 'Undo chunk' },
  ['n gcs'] = { [[<Cmd>CocCommand git.chunkStage<CR>]], description = 'Stage chunk' },
  ['n gcn'] = { [[<Plug>(coc-git-nextchunk)]], description = 'Next chunk', noremap = false },
  ['n gcp'] = { [[<Plug>(coc-git-prevchunk)]], description = 'Previous chunk', noremap = false },
  ['n gci'] = { [[<Plug>(coc-git-chunkinfo)]], description = 'Chunk info', noremap = false },
  ['n gB'] = { function() steelvim.checkout_git_branch_fzf(nvim.fn.expand("%:p:h")) end , description = 'Checkout branch' },
  ['n gs'] = { [[<Cmd>G<CR>]], description = 'Git status' },
  ['n gd'] = { [[<Cmd>Gdiffsplit<CR>]], description = 'Git diff' },
  ['n ge'] = { [[<Cmd>Gedit<CR>]], description = 'Git edit' },
  ['n gg'] = { [[<Cmd>Git<Space>]], description = 'Git command' },
  ['n gl'] = { [[<Cmd>Commits<CR>]], description = 'Git log' },
  ['n gL'] = { [[<Cmd>BCommits<CR>]], description = 'Git file log' },
  ['n gf'] = { [[<Cmd>Gfetch<CR>]], description = 'Git fetch' },
  ['n gp'] = { [[<Cmd>Gpull<CR>]], description = 'Git pull' },
  ['n gP'] = { [[<Cmd>Gpush<CR>]], description = 'Git push' },
  ['n gb'] = { [[<Cmd>Gblame<CR>]], description = 'Git blame' },
  ['n gS'] = { function() steelvim.float_fzf_cmd("gss") end, description = 'Browse stash' },
  ['n gr'] = { function() steelvim.float_fzf_cmd("grh") end, description = 'Reset files to head' },
  ['n gD'] = { function() steelvim.float_fzf_cmd("gd") end, description = 'Diff files' },
  ['n ga'] = { function() steelvim.float_fzf_cmd("ga") end, description = 'Add files' },
  -- Terminal mappings <leader>t
  ['n tt'] = { function() steelvim.float_term(false) end, description = 'Float terminal' },
  ['n tT'] = { function() steelvim.float_term(true) end, description = 'Float terminal (full)' },
  ['n tv'] = { function() 
    nvim.ex.vsp()
    steelvim.open_term() 
  end, description = 'Vertical split terminal' },
  ['n tf'] = { function()
    nvim.ex.vsp()
    steelvim.open_term(true)
  end, description = 'Terminal at file' }
}

local which_key_map = {
  [' '] = 'Ex command',
  ['/'] = { name = '+search' },
  f = { name = '+file' },
  b = { name = '+buffers' },
  w = { name = '+windows', b = { name = '+balance' } },
  y = { name = '+yank' },
  g = { name = '+git', c = { name = '+chunk' } },
  p = { name = '+project' },
  c = { 
    name = '+code', 
    c = {
      name = '+case',
      p = 'PascalCase',
      m = 'MixedCase',
      c = 'camelCase',
      u = 'UPPER CASE',
      U = 'UPPER CASE',
      t = 'Title Case',
      s = 'Sentence case',
      ['_'] = 'snake_case',
      k = 'kebab-case',
      ['-'] = 'dash-case',
      [' '] = 'space case',
      ['.'] = 'dot.case'
    }
  },
  -- Locals need to be defined per filetype
  m = { name = '+local' },
  d = { name = '+documentation' },
  j = { 
    name = '+jump', 
    m = { name = '+marks' },
    c = { name = '+changes' }, 
    e = { name = '+errors' }
  },
  t = { name = '+terminal' }
}

mapping_utils.register_mappings(mappings, { noremap = true }, which_key_map)
nvim.g.which_key_map = which_key_map

-- I can't get the following mappings to work in lua...
nvim.command [[
function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]]

nvim.command [[inoremap <silent><expr> <C-SPACE> coc#refresh()]]

-- Use tab for trigger completion with characters ahead and navigate.
-- Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
nvim.command [[inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : CheckBackSpace() ? "\<TAB>" : coc#refresh()]]
nvim.command [[inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"]]

-- Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
-- Coc only does snippet and additional edit on confirm.
nvim.command [[inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"]]
