local nvim = require 'nvim'
local mapping_utils = require 'steelvim/utils/mappings'
local fzf_diagnostics = require 'steelvim/fzf/diagnostics'
local git = require 'steelvim/git'
local terminal = require 'steelvim/terminal'
local which_key = require 'steelvim/which_key'
local common = require 'steelvim/common'
local buffers = require 'steelvim/buffers'
local grep = require 'steelvim/grep'
local quickfix = require 'steelvim/quickfix'
local files = require 'steelvim/files'
local source = require 'source'

local unimplemented = mapping_utils.unimplemented;

local mappings = {
  ['n '] = { function() which_key.start(false) end, silent = true },
  ['v '] = { function() which_key.start(true) end, silent = true },
  ['i<C-space>'] = { function() vim.lsp.omnifunc() end, silent = true },
  ['n <CR>'] = { [[:Marks<CR>]], description = 'Jump to mark' },
  ['ijj'] = { [[<esc>]], description = 'Exit insert mode' },
  ['i<C-j>'] = { function() source.prevCompletion() end },
  ['i<C-k>'] = { function() source.nextCompletion() end },
  ['t<C-j><C-j>'] = { [[<C-\><C-n>]], description = 'Exit terminal mode' },
  ['nU'] = { [[<C-r>]], description = 'Redo' },
  ['n/'] = { [[/\v]], description = 'Search with magic' },
  ['n?'] = { [[?\v]], description = 'Search backwards with magic' },
  ['nK'] = { function() common.show_documentation() end, description = 'Show documentation', silent = true },
  ['ngh'] = { function() common.show_documentation(true) end, description = 'Show documentation', silent = true },
  -- Completion for all lines in all buffers
  ['i<C-l>'] = { [[<Plug>(fzf-complete-line)]] },
  ['i<C-e>'] = { [[<Plug>(fzf-complete-path)]] },
  ['i<C-w>'] = { [[<Plug>(fzf-complete-word)]] },
  ['i<C-u>'] = { function() files.insert_relative_path(vim.fn.expand('%:p:h')) end },
  ['ngd'] = { function() vim.lsp.buf.definition() end, silent = true },
  ['ngy'] = { function() vim.lsp.buf.type_definition()  end, silent = true },
  ['ngi'] = { function() vim.lsp.buf.implementation() end, silent = true },
  ['ngr'] = { function() vim.lsp.buf.references()  end, silent = true },
  ['nf'] = { [[<Plug>Sneak_f]] },
  ['nF'] = { [[<Plug>Sneak_F]] },
  ['xf'] = { [[<Plug>Sneak_f]] },
  ['xF'] = { [[<Plug>Sneak_F]] },
  ['of'] = { [[<Plug>Sneak_f]] },
  ['oF'] = { [[<Plug>Sneak_F]] },
  ['nt'] = { [[<Plug>Sneak_t]] },
  ['nT'] = { [[<Plug>Sneak_T]] },
  ['xt'] = { [[<Plug>Sneak_t]] },
  ['xT'] = { [[<Plug>Sneak_T]] },
  ['ot'] = { [[<Plug>Sneak_t]] },
  ['oT'] = { [[<Plug>Sneak_T]] },
  ['n ,'] = { [[<Cmd>Buffers<CR>]], description = 'Switch buffer' },
  ['n .'] = { [[<Cmd>Files<CR>]], description = 'Find files' },
  ['n  '] = { [[<Cmd>Commands<CR>^]] },
  ['n x'] = { [[<Cmd>sp e<CR>]], description = 'Scratch buffer' },
  -- File mappings <leader>f
  ['n fs'] = { [[<Cmd>w<CR>]], description = 'Save file' },
  ['n fS'] = { [[<Cmd>wa<CR>]], description = 'Save all files' },
  ['n f/'] = { [[<Cmd>BLines<CR>]], description = 'Search lines' },
  ['n ff'] = { [[<Plug>(Prettier)]], description = 'Format file' },
  ['n fo'] = { [[<Cmd>Dirvish %:p:h<CR>]], description = 'Show in tree' },
  ['n fO'] = { [[<Cmd>vsp +Dirvish %:p:h<CR>]], description = 'Show in split tree' },
  -- ['n fr'] = { [[<Cmd>CocList mru<CR>]], description = 'Open recent files' },
  ['n fu'] = { [[<Cmd>UndotreeToggle<CR>]], description = 'Undo tree' },
  ['n fU'] = { [[<Cmd>UndotreeFocus<CR>]], description = 'Focus undo tree' },
  ['n fE'] = { [[<Cmd>vsp $MYVIMRC<CR>]], description = 'Edit .vimrc' },
  ['n fF'] = { [[<Cmd>Files %:p:h<CR>]], description = 'Find from file' },
  ['n fP'] = { [[<Cmd>Files ~/.vim/lua<CR>]], description = 'Find config file' },
  ['n fx'] = { function() fzf_diagnostics.open_diagnostics(true) end, description = 'List file diagnostics' },
  -- Buffer mappings <leader>b
  ['n bp'] = { [[<Cmd>bprevious<CR>]], description = 'Previous buffer' },
  ['n bn'] = { [[<Cmd>bnext<CR>]], description = 'Next buffer' },
  ['n bf'] = { [[<Cmd>bfirst<CR>]], description = 'First buffer' },
  ['n bl'] = { [[<Cmd>blast<CR>]], description = 'Last buffer' },
  ['n bd'] = { [[<Cmd>bp<CR>:bd#<CR>]], description = 'Delete buffer' },
  ['n bk'] = { [[<Cmd>bp<CR>:bw!#<CR>]], description = 'Wipe buffer' },
  ['n bK'] = { function() buffers.delete_buffers_fzf() end, description = 'Wipe buffers' },
  ['n bb'] = { [[<Cmd>Buffers<CR>]], description = 'List buffers' },
  ['n bY'] = { [[ggyG]], description = 'Yank buffer' },
  ['n bm'] = { function() common.prompt_command('mark', 'Set mark') end, description = 'Set mark' },
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
  ['n ps'] = { function()
    local word = vim.fn.expand("<cword>")

    nvim.ex.Files('.') 
    nvim.input(word)
  end, description = 'Find file with text' },
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
  ['n jd'] = { function() vim.lsp.buf.definition()  end, description = 'Definition' },
  ['n ji'] = { function() vim.lsp.buf.implementation() end, description = 'Implementation' },
  ['n jy'] = { function() vim.lsp.buf.type_definition() end, description = 'Type definition' },
  ['n jr'] = { function() vim.lsp.buf.references() end, description = 'Type references' },
  ['n jep'] = { [[<Cmd>PrevDiagnosticCycle<CR>]], description = 'Previous error' },
  ['n jen'] = { [[<Cmd>NextDiagnosticCycle<CR>]], description = 'Next error' },
  ['n jqp'] = { [[<Cmd>cN<CR>]], description = 'Previous' },
  ['n jqn'] = { [[<Cmd>cn<CR>]], description = 'Next' },
  ['n jn'] = { [[<C-o>]], description = 'Next jump' },
  ['n jp'] = { [[<C-i>]], description = 'Previous jump' },
  ['n jml'] = { [[<Cmd>Marks<CR>]], description = 'List marks' },
  ['n jmd'] = { [[:delmarks<Space>]], description = 'Delete marks' },
  ['n jmm'] = { [[`]], description = 'Go to mark' },
  ['n ja'] = { [[<Cmd>A<CR>]], description = 'Go to altenate' },
  ['n jA'] = { [[<Cmd>AV<CR>]], description = 'Split altenate' },
  ['n jcn'] = { [[g,]], description = 'Next change' },
  ['n jcp'] = { [[g;]], description = 'Previous change' },
  -- Insert mappings <leader>i
  ['n if'] = { [["%p]], description = 'Current file name' },
  ['n iF'] = { [[<Cmd>put = expand('%:p')<CR>]], description = 'Current file path' },
  -- ['n iy'] = { [[<Cmd>CocList -A --normal yank<CR>]], description = 'From clipboard' },
  ['n is'] = { [[<Cmd>Snippets<CR>]], description = 'Insert snippet' },
  -- Search mappings <leader>s
  ['n sd'] = { [[<Cmd>FlyDRg<CR>]], description = 'Grep files in directory' },
  ['n sc'] = { [[<Cmd>History:<CR>]], description = 'Search command history' },
  ['n sh'] = { [[<Cmd>History/<CR>]], description = 'Search history' },
  ['n si'] = { function() vim.lsp.buf.workspace_symbol() end, description = 'Search symbol' },
  ['n sb'] = { [[<Cmd>BLines<CR>]], description = 'Search buffer' },
  ['n ss'] = { [[<Cmd>BLines<CR>]], description = 'Search buffer' },
  ['n so'] = { function() vim.lsp.buf.document_symbol() end, description = 'List symbols in file' },
  ['n sl'] = { [[<Cmd>Lines<CR>]], description = 'Search lines' },
  ['n sp'] = { [[<Cmd>FlyRg<CR>]], description = 'Grep files in project' },
  ['n sP'] = { [[<Cmd>FlyRg!<CR>]], description = 'Grep files in project (full),' },
  ['n sm'] = { [[<Cmd>Marks<CR>]], description = 'Jump to marks' },
  ['n sa'] = { function()
    grep.flygrep('', vim.fn.expand('%:p:h'), 0, { '--hidden', '--no-ignore' })
  end, description = 'Grep all files' },
  ['n sS'] = { [[:Rg <C-r><C-w><CR>]], description = 'Search selected text (project)' },
  -- Local Search/Replace mappings <leader>/
  ['n /h'] = { [[<Cmd>noh<CR>]], description = 'Clear searh highlight' },
  ['n /s'] = { [[g*N]], description = 'Search selected text' },
  ['v /s'] = { [["9y/<C-r>9<CR>]] },
  ['v /S'] = { [["9y:Rg <C-r>9<CR>]] },
  ['n /r'] = { function()
    nvim.ex.normal('g*')
    nvim.input(':%s//')
  end, description = 'Replace selected text' },
  -- Yank with preview <leader>y
  -- ['n yl'] = { [[<Cmd>CocList -A --normal yank<CR>]], description = 'List yanks' },
  ['n yf'] = { [[<Cmd>let @" = expand("%:p")<CR>]], description = 'Yank file path' },
  ['n yF'] = { [[<Cmd>let @" = expand("%:t:r")<CR>]], description = 'Yank file name' },
  ['n yy'] = { [["+y]], description = 'Yank to clipboard' },
  ['v yy'] = { [["+y]] },
  -- Code mappings <leader>c
  ['n cl'] = { [[<Cmd>Commentary<CR>]], description = 'Comment line' },
  ['v cl'] = { [[:Commentary<CR>]] },
  ['n cX'] = { function() fzf_diagnostics.open_diagnostics() end, description = 'Find errors' },
  ['n cx'] = { [[<Cmd>OpenDiagnostic<CR>]], description = 'List errors' },
  ['n cd'] = { function() vim.lsp.buf.definition() end, description = 'Definition' },
  ['n cD'] = { function() vim.lsp.buf.references() end, description = 'Type references' },
  ['n ck'] = { [[gh]], description = 'Jump to documentation', noremap = false },
  ['n cr'] = { function() vim.lsp.buf.rename() end, description = 'LSP rename' },
  ['n cR'] = { function() 
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    nvim.ex.edit()
  end, description = 'LSP reload' },
  ['n cs'] = { function() vim.lsp.buf.signature_help() end, description = 'Signature help' },
  ['n cj'] = { function() vim.lsp.buf.document_symbol() end, description = 'Jump to symbol' },
  ['n cJ'] = { function() vim.lsp.buf.workspace_symbol() end, description = 'Jump to symbol in workspace' },
  ['n ca'] = { function() vim.lsp.buf.code_action() end, description = 'LSP code actions' },
  ['n cql'] = { function()
    local line = vim.fn.getpos(".")[2]
    quickfix.add_line_to_quickfix(line, line)
  end, description = 'Add line to quickfix' },
  ['v cql'] = { function()
    quickfix.add_line_to_quickfix(vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2])
  end, description = 'Add line to quickfix' },
  ['n cqn'] = { function() quickfix.new_qf_list() end, description = 'New quickfix list' },
  -- Documentation mappings <leader>d
  ['n dd'] = { [[<Plug>(doge-generate)]], description = 'Document' },
  -- Git mappings <leader>g
  ['n gcu'] = { [[<Cmd>GitGutterUndoHunk<CR>]], description = 'Undo chunk' },
  ['n gcs'] = { [[<Cmd>GitGutterStageHunk<CR>]], description = 'Stage chunk' },
  ['n gcn'] = { [[<Cmd>GitGutterNextHunk<CR>]], description = 'Next chunk' },
  ['n gcp'] = { [[<Cmd>GitGutterPrevHunk<CR>]], description = 'Previous chunk' },
  ['n gci'] = { [[<Cmd>GitGutterPreviewHunk<CR>]], description = 'Chunk info' },
  ['n gB'] = { function() git.checkout_git_branch_fzf(vim.fn.expand("%:p:h")) end , description = 'Checkout branch' },
  ['n gs'] = { [[<Cmd>G<CR>]], description = 'Git status' },
  ['n gd'] = { [[<Cmd>Gdiffsplit<CR>]], description = 'Git diff' },
  ['n ge'] = { [[<Cmd>Gedit<CR>]], description = 'Git edit' },
  ['n gg'] = { [[:Git<Space>]], description = 'Git command' },
  ['n gl'] = { [[<Cmd>Commits<CR>]], description = 'Git log' },
  ['n gL'] = { [[<Cmd>BCommits<CR>]], description = 'Git file log' },
  ['n gF'] = { [[<Cmd>Gfetch<CR>]], description = 'Git fetch' },
  ['n gp'] = { [[<Cmd>Gpull<CR>]], description = 'Git pull' },
  ['n gP'] = { [[<Cmd>Gpush<CR>]], description = 'Git push' },
  ['n gb'] = { [[<Cmd>Gblame<CR>]], description = 'Git blame' },
  ['n gr'] = { function() terminal.float_fzf_cmd("grh") end, description = 'Reset files to head' },
  ['n gD'] = { function() terminal.float_fzf_cmd("gd") end, description = 'Diff files' },
  ['n ga'] = { function() terminal.float_fzf_cmd("ga") end, description = 'Add files' },
  ['n gC'] = { function() terminal.float_fzf_cmd("gcf") end, description = 'Checkout files' },
  ['n gfc'] = { function() unimplemented() end, description = 'Find commit' },
  ['n gff'] = { function() unimplemented() end, description = 'Find file' },
  ['n gfg'] = { function() unimplemented() end, description = 'Find gitconfig file' },
  ['n gfi'] = { function() unimplemented() end, description = 'Find issue' },
  ['n gfp'] = { function() unimplemented() end, description = 'Find pull request' },
  ['n gfs'] = { function() terminal.float_fzf_cmd("gss") end, description = 'Find stash' },
  -- Terminal mappings <leader>wt
  ['n wtt'] = { function() terminal.float(false) end, description = 'Float terminal' },
  ['n wtT'] = { function() terminal.float(true) end, description = 'Float terminal (full)' },
  ['n wtv'] = { function() 
    nvim.ex.vsp()
    terminal.open_term() 
  end, description = 'Vertical split terminal' },
  ['n wtf'] = { function()
    nvim.ex.vsp()
    terminal.open_term(true)
  end, description = 'Terminal at file' },
  -- Toggle mappings <leader>t
  ['n tl'] = { function() unimplemented() end, description = 'Line numbers' },
  ['n tw'] = { [[<Cmd>set wrap!<CR>]], description = 'Word wrap' },
  ['n tr'] = { [[<Cmd>set modifiable!<CR>]], description = 'Read only' },
  ['n ts'] = { [[<Cmd>set spell!<CR>]], description = 'Spell check' },
  ['n te'] = { function()
    local cur = nvim.g.diagnostic_enable_virtual_text

    if cur == 1 then
      nvim.g.diagnostic_enable_virtual_text = 0
    else
      nvim.g.diagnostic_enable_virtual_text = 1
    end
  end, description = 'Inline errors' },
  -- Help mappings <leader>h
  ['n hh'] = { [[<Cmd>Helptags<CR>]], description = 'Help tags' }
  -- ['n hs'] = { [[<Cmd>CocList snippets<CR>]], description = 'Snippets list' }
}

local which_key_map = {
  [' '] = 'Ex command',
  ['/'] = { name = '+local-search' },
  s = { name = '+search' },
  f = { name = '+file' },
  b = { name = '+buffers' },
  w = { name = '+windows', b = { name = '+balance' }, t = { name = '+terminal' } },
  y = { name = '+yank' },
  i = { name = '+insert' },
  g = { name = '+git', c = { name = '+chunk' }, f = { name = '+find' } },
  p = { name = '+project' },
  h = { name = '+help' },
  c = { 
    name = '+code', 
    q = { name = '+quickfix' },
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
    e = { name = '+errors' },
    q = { name = '+quickfix' }
  },
  t = { name = '+toggle' }
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

-- Use tab for trigger completion with characters ahead and navigate.
-- Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
nvim.command [[inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : CheckBackSpace() ? "\<TAB>" : completion#trigger_completion()]]
nvim.command [[inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"]]
nvim.command [[inoremap <expr> <cr> pumvisible() ? "\<Plug>(completion_confirm_completion)" : "\<cr>"]]

-- Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
-- Coc only does snippet and additional edit on confirm.
-- nvim.command [[inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"]]
