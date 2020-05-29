local source = require 'source'

local unimplemented = steel.mappings.unimplemented;

local mappings = {
  ['n '] = { function() steel.wk.start(false) end, silent = true },
  ['v '] = { function() steel.wk.start(true) end, silent = true },
  ['i<C-Space>'] = { [[completion#trigger_completion()]], silent = true, expr = true },
  ['n <CR>'] = { [[:Marks<CR>]], description = 'Jump to mark' },
  ['ijj'] = { [[<esc>]], description = 'Exit insert mode' },
  ['i<C-j>'] = { function() source.prevCompletion() end },
  ['i<C-k>'] = { function() source.nextCompletion() end },
  ['t<C-j><C-j>'] = { [[<C-\><C-n>]], description = 'Exit terminal mode' },
  ['nU'] = { [[<C-r>]], description = 'Redo' },
  ['n/'] = { [[/\v]], description = 'Search with magic' },
  ['n?'] = { [[?\v]], description = 'Search backwards with magic' },
  ['nK'] = { function() steel.common.show_documentation() end, description = 'Show documentation', silent = true },
  ['ngh'] = { function() steel.common.show_documentation(true) end, description = 'Show documentation', silent = true },
  -- Completion for all lines in all buffers
  ['i<C-l>'] = { [[<Plug>(fzf-complete-line)]] },
  ['i<C-e>'] = { [[<Plug>(fzf-complete-path)]] },
  ['i<C-w>'] = { [[<Plug>(fzf-complete-word)]] },
  ['i<C-u>'] = { function() steel.files.insert_relative_path(vim.fn.expand('%:p:h')) end },
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
  ['n fr'] = { [[<Cmd>History<CR>]], description = 'Open recent files' },
  ['n fu'] = { [[<Cmd>UndotreeToggle<CR>]], description = 'Undo tree' },
  ['n fU'] = { [[<Cmd>UndotreeFocus<CR>]], description = 'Focus undo tree' },
  ['n fE'] = { [[<Cmd>vsp $MYVIMRC<CR>]], description = 'Edit .vimrc' },
  ['n fF'] = { [[<Cmd>Files %:p:h<CR>]], description = 'Find from file' },
  ['n fP'] = { [[<Cmd>Files ~/.vim/lua<CR>]], description = 'Find config file' },
  ['n fx'] = { function() steel.diagnostics.open_diagnostics(true) end, description = 'List file diagnostics' },
  -- Buffer mappings <leader>b
  ['n bp'] = { [[<Cmd>bprevious<CR>]], description = 'Previous buffer' },
  ['n bn'] = { [[<Cmd>bnext<CR>]], description = 'Next buffer' },
  ['n bf'] = { [[<Cmd>bfirst<CR>]], description = 'First buffer' },
  ['n bl'] = { [[<Cmd>blast<CR>]], description = 'Last buffer' },
  ['n bd'] = { [[<Cmd>bp<CR>:bd#<CR>]], description = 'Delete buffer' },
  ['n bk'] = { [[<Cmd>bp<CR>:bw!#<CR>]], description = 'Wipe buffer' },
  ['n bK'] = { function() steel.buf.delete_buffers_fzf() end, description = 'Wipe buffers' },
  ['n bb'] = { [[<Cmd>Buffers<CR>]], description = 'List buffers' },
  ['n bY'] = { [[ggyG]], description = 'Yank buffer' },
  ['n bm'] = { function() steel.common.prompt_command('mark', 'Set mark') end, description = 'Set mark' },
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

    steel.ex.Files('.') 
    vim.api.nvim_input(word)
  end, description = 'Find file with text' },
  ['n pT'] = { [[<Cmd>vsp +Dirvish<CR>]], description = 'Open File explorer in split' },
  ['n pt'] = { [[<Cmd>Dirvish<CR>]], description = 'Open file Explorer' },
  ['n pq'] = { [[<Cmd>qall<CR>]], description = 'Quit project' },
  ['n pc'] = { function() steel.project.cd_to_root() end, description = 'Cwd to root' },
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
    steel.grep.flygrep('', vim.fn.expand('%:p:h'), 0, { '--hidden', '--no-ignore' })
  end, description = 'Grep all files' },
  ['n sS'] = { [[:Rg <C-r><C-w><CR>]], description = 'Search selected text (project)' },
  -- Local Search/Replace mappings <leader>/
  ['n /h'] = { [[<Cmd>noh<CR>]], description = 'Clear searh highlight' },
  ['n /s'] = { [[g*N]], description = 'Search selected text' },
  ['v /s'] = { [["9y/<C-r>9<CR>]] },
  ['v /S'] = { [["9y:Rg <C-r>9<CR>]] },
  ['n /r'] = { function()
    steel.ex.normal('g*')
    vim.api.nvim_input(':%s//')
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
  ['n cx'] = { function() steel.diagnostics.open_diagnostics({ bufnr = vim.fn.bufnr("%") }) end, description = 'Document diagnostics' },
  ['n cX'] = { function() steel.diagnostics.open_diagnostics() end, description = 'Workspace diagnostics' },
  ['n cd'] = { function() vim.lsp.buf.definition() end, description = 'Definition' },
  ['n cD'] = { function() vim.lsp.buf.references() end, description = 'Type references' },
  ['n ck'] = { [[gh]], description = 'Jump to documentation', noremap = false },
  ['n cr'] = { function() vim.lsp.buf.rename() end, description = 'LSP rename' },
  ['n cR'] = { function() 
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    steel.command("e!")
  end, description = 'LSP reload' },
  ['n cs'] = { function() vim.lsp.buf.signature_help() end, description = 'Signature help' },
  ['n cj'] = { function() vim.lsp.buf.document_symbol() end, description = 'Jump to symbol' },
  ['n cJ'] = { function() vim.lsp.buf.workspace_symbol() end, description = 'Jump to symbol in workspace' },
  ['n ca'] = { function() vim.lsp.buf.code_action() end, description = 'LSP code actions' },
  ['n cql'] = { function()
    local line = vim.fn.getpos(".")[2]
    steel.qf.add_line_to_quickfix(line, line)
  end, description = 'Add line to quickfix' },
  ['v cql'] = { function()
    steel.qf.add_line_to_quickfix(vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2])
  end, description = 'Add line to quickfix' },
  ['n cqn'] = { function() quickfix.new_qf_list() end, description = 'New quickfix list' },
  -- Git mappings <leader>g
  ['n gcu'] = { [[<Cmd>GitGutterUndoHunk<CR>]], description = 'Undo chunk' },
  ['n gcs'] = { [[<Cmd>GitGutterStageHunk<CR>]], description = 'Stage chunk' },
  ['n gcn'] = { [[<Cmd>GitGutterNextHunk<CR>]], description = 'Next chunk' },
  ['n gcp'] = { [[<Cmd>GitGutterPrevHunk<CR>]], description = 'Previous chunk' },
  ['n gci'] = { [[<Cmd>GitGutterPreviewHunk<CR>]], description = 'Chunk info' },
  ['n gB'] = { function() steel.git.checkout_git_branch_fzf(vim.fn.expand("%:p:h")) end , description = 'Checkout branch' },
  ['n gs'] = { [[<Cmd>G<CR>]], description = 'Git status' },
  ['n gd'] = { [[<Cmd>Gdiffsplit<CR>]], description = 'Git diff' },
  ['n ge'] = { [[<Cmd>Gedit<CR>]], description = 'Git edit' },
  ['n gg'] = { function() steel.term.float_cmd('lazygit') end, description = 'Git GUI' },
  ['n gl'] = { [[<Cmd>Commits<CR>]], description = 'Git log' },
  ['n gL'] = { [[<Cmd>BCommits<CR>]], description = 'Git file log' },
  ['n gF'] = { [[<Cmd>Gfetch<CR>]], description = 'Git fetch' },
  ['n gp'] = { [[<Cmd>Gpull<CR>]], description = 'Git pull' },
  ['n gP'] = { [[<Cmd>Gpush<CR>]], description = 'Git push' },
  ['n gb'] = { [[<Cmd>Gblame<CR>]], description = 'Git blame' },
  ['n gfc'] = { function() unimplemented() end, description = 'Find commit' },
  ['n gff'] = { function() unimplemented() end, description = 'Find file' },
  ['n gfg'] = { function() unimplemented() end, description = 'Find gitconfig file' },
  ['n gfi'] = { function() unimplemented() end, description = 'Find issue' },
  ['n gfp'] = { function() unimplemented() end, description = 'Find pull request' },
  -- Terminal mappings <leader>wt
  ['n wtt'] = { function() steel.term.float(false) end, description = 'Float terminal' },
  ['n wtT'] = { function() steel.term.float(true) end, description = 'Float terminal (full)' },
  ['n wtv'] = { function() 
    steel.ex.vsp()
    steel.term.open_term() 
  end, description = 'Vertical split terminal' },
  ['n wtf'] = { function()
    steel.ex.vsp()
    steel.term.open_term(true)
  end, description = 'Terminal at file' },
  -- Toggle mappings <leader>t
  ['n tl'] = { function() unimplemented() end, description = 'Line numbers' },
  ['n tw'] = { [[<Cmd>set wrap!<CR>]], description = 'Word wrap' },
  ['n tr'] = { [[<Cmd>set modifiable!<CR>]], description = 'Read only' },
  ['n ts'] = { [[<Cmd>set spell!<CR>]], description = 'Spell check' },
  ['n te'] = { function()
    local cur = vim.g.diagnostic_enable_virtual_text

    if cur == 1 then
      vim.g.diagnostic_enable_virtual_text = 0
    else
      vim.g.diagnostic_enable_virtual_text = 1
    end
  end, description = 'Inline errors' },
  -- Help mappings <leader>h
  ['n hh'] = { [[<Cmd>Helptags<CR>]], description = 'Help tags' },
  ['n hs'] = { [[<Cmd>UltiSnippetsEdit<CR>]], description = 'Edit snippets' }
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

steel.mappings.register_mappings(mappings, { noremap = true }, which_key_map)
vim.g.which_key_map = which_key_map

-- I can't get the following mappings to work in lua...
steel.command [[
function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]]

-- Use tab for trigger completion with characters ahead and navigate.
-- Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
steel.command [[inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : CheckBackSpace() ? "\<TAB>" : completion#trigger_completion()]]
steel.command [[inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"]]
steel.command [[inoremap <expr> <cr> pumvisible() ? "\<Plug>(completion_confirm_completion)" : "\<cr>"]]
