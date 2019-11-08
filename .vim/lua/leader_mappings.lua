local leader_mappings = {
  { mode = 'nnoremap', keys = {','}, action = ':Buffers<CR>', description = 'Switch buffer' },
  { mode = 'nnoremap', keys = {'.'}, action = ':Files<CR>', description = 'Find files' },
  { mode = 'nnoremap', keys = {"<Space>"}, action = ':Commands<CR>^' },
  -- File mappings <leader>f
  { mode = 'nnoremap <silent>', keys = {'f', 's'}, action = ':w<CR>', description = 'Save file' },
  { mode = 'nnoremap <silent>', keys = {'f', 'S'}, action = ':wa<CR>', description = 'Save all files' },
  { mode = 'nnoremap <silent>', keys = {'f', '/'}, action = ':BLines<CR>', description = 'Search lines' },
  { mode = 'nnoremap <silent>', keys = {'f', 'f'}, action = ':call CocAction("format")<CR>', description = 'Format file' },
  { mode = 'nnoremap <silent>', keys = {'f', 'o'}, action = ':Dirvish %:p:h<CR>', description = 'Show in tree' },
  { mode = 'nnoremap <silent>', keys = {'f', 'O'}, action = ':vsp +Dirvish %:p:h<CR>', description = 'Show in split tree' },
  { mode = 'nnoremap <silent>', keys = {'f', 'r'}, action = ':CocList mru<CR>', description = 'Open recent files' },
  { mode = 'nnoremap <silent>', keys = {'f', 'u'}, action = ':UndotreeToggle<CR>', description = 'Undo tree' },
  { mode = 'nnoremap <silent>', keys = {'f', 'U'}, action = ':UndotreeFocus<CR>', description = 'Focus undo tree' },
  { mode = 'nnoremap <silent>', keys = {'f', 'E'}, action = ':vsp $MYVIMRC<CR>', description = 'Edit .vimrc' },
  { mode = 'nnoremap <silent>', keys = {'f', 'F'}, action = ':Files %:p:h<CR>', description = 'Find from file' },
  -- Buffer mappings <leader>b
  { mode = 'nnoremap <silent>', keys = {'b', 'p'}, action = ':bprevious<CR>', description = 'Previous buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'n'}, action = ':bnext<CR>', description = 'Next buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'f'}, action = ':bfirst<CR>', description = 'First buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'l'}, action = ':blast<CR>', description = 'Last buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'd'}, action = ':bp<CR>:bd#<CR>', description = 'Delete buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'k'}, action = ':bp<CR>:bw!#<CR>', description = 'Wipe buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'b'}, action = ':Buffers<CR>', description = 'List buffers' },
  { mode = 'nnoremap <silent>', keys = {'b', 'Y'}, action = 'ggyG', description = 'Yank buffer' },
  -- Window mappings <leader>w
  { mode = 'nnoremap <silent>', keys = {'w', 'w'}, action = '<C-W>w', description = 'Move below/right' },
  { mode = 'nnoremap <silent>', keys = {'w', 'a'}, action = ':Windows<CR>', description = 'List windows' },
  { mode = 'nnoremap <silent>', keys = {'w', 'd'}, action = '<C-W>c', description = 'Delete window' },
  { mode = 'nnoremap <silent>', keys = {'w', 's'}, action = '<C-W>s', description = 'Split window' },
  { mode = 'nnoremap <silent>', keys = {'w', 'v'}, action = '<C-W>v', description = 'Split window vertical' },
  { mode = 'nnoremap <silent>', keys = {'w', 'n'}, action = '<C-W>n', description = 'New window' },
  { mode = 'nnoremap <silent>', keys = {'w', 'q'}, action = '<C-W>q', description = 'Quit window' },
  { mode = 'nnoremap <silent>', keys = {'w', 'j'}, action = '<C-W>j', description = 'Move down' },
  { mode = 'nnoremap <silent>', keys = {'w', 'k'}, action = '<C-W>k', description = 'Move up' },
  { mode = 'nnoremap <silent>', keys = {'w', 'h'}, action = '<C-W>h', description = 'Move left' },
  { mode = 'nnoremap <silent>', keys = {'w', 'l'}, action = '<C-W>l', description = 'Move right' },
  { mode = 'nnoremap <silent>', keys = {'w', 'J'}, action = '<C-W>J', description = 'Move window down' },
  { mode = 'nnoremap <silent>', keys = {'w', 'K'}, action = '<C-W>K', description = 'Move window up' },
  { mode = 'nnoremap <silent>', keys = {'w', 'H'}, action = '<C-W>H', description = 'Move window left' },
  { mode = 'nnoremap <silent>', keys = {'w', 'L'}, action = '<C-W>L', description = 'Move window right' },
  { mode = 'nnoremap <silent>', keys = {'w', 'r'}, action = '<C-W>r', description = 'Rotate forward' },
  { mode = 'nnoremap <silent>', keys = {'w', 'R'}, action = '<C-W>R', description = 'Rotate backwards' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', 'j'}, action = ':resize -5<CR>', description = 'Shrink' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', 'k'}, action = ':resize +5<CR>', description = 'Grow' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', 'l'}, action = ':vertical resize +5<CR>', description = 'Vertical grow' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', 'h'}, action = ':vertical resize -5<CR>', description = 'Vertical shrink' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', 'J'}, action = ':resize -20<CR>', description = 'Shrink large' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', 'K'}, action = ':resize +20<CR>', description = 'Grow large' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', 'L'}, action = ':vertical resize +20<CR>', description = 'Vertical grow large' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', 'H'}, action = ':vertical resize -20<CR>', description = 'Vertical shrink large' },
  { mode = 'nnoremap <silent>', keys = {'w', 'b', '='}, action = '<C-W>=', description = 'Balance splits' },
  { mode = 'nnoremap <silent>', keys = {'w', '='}, action = '<C-W>=', description = 'Balance splits' },
  { mode = 'nnoremap <silent>', keys = {'w', 'F'}, action = ':tabnew<CR>', description = 'New tab' },
  { mode = 'nnoremap <silent>', keys = {'w', 'o'}, action = ':tabnext<CR>', description = 'Next tab' },
  { mode = 'nnoremap <silent>', keys = {'w', '/'}, action = ':Windows<CR>', description = 'Search windows' },
  -- Project mappings <leader>p
  { mode = 'nnoremap <silent>', keys = {'p', 'f'}, action = ':Files .<CR>', description = 'Find file' },
  { mode = 'nnoremap <silent>', keys = {'p', 'F'}, action = ':Files! .<CR>', description = 'Find file fullscreen' },
  { mode = 'nnoremap <silent>', keys = {'p', 'T'}, action = ':vsp +Dirvish<CR>', description = 'Open File explorer in split' },
  { mode = 'nnoremap <silent>', keys = {'p', 't'}, action = ':Dirvish<CR>', description = 'Open file Explorer' },
  { mode = 'nnoremap <silent>', keys = {'p', 'q'}, action = ':qall<CR>', description = 'Quit project' },
  -- Workspace mappings <leader>q
  { mode = 'nnoremap <silent>', keys = {'q'}, action = ':q<CR>', description = 'Quit' },
  { mode = 'nnoremap <silent>', keys = {'Q'}, action = ':q!<CR>', description = 'Force quit' },
  -- Navigation mappings <leader>j
  { mode = 'nnoremap <silent>', keys = {'j', 'l'}, action = '$', description = 'End of line' },
  { mode = 'vnoremap <silent>', keys = {'j', 'l'}, action = '$', description = 'End of line', 1 },
  { mode = 'nnoremap <silent>', keys = {'j', 'h'}, action = '0', description = 'Start of line' },
  { mode = 'vnoremap <silent>', keys = {'j', 'h'}, action = '0', description = 'Start of line', 1 },
  { mode = 'nnoremap <silent>', keys = {'j', 'k'}, action = '<C-b>', description = 'Page up' },
  { mode = 'vnoremap <silent>', keys = {'j', 'k'}, action = '<C-b>', description = 'Page up', 1 },
  { mode = 'nnoremap <silent>', keys = {'j', 'j'}, action = '<C-f>', description = 'Page down' },
  { mode = 'vnoremap <silent>', keys = {'j', 'j'}, action = '<C-f>', description = 'Page down', 1 },
  { mode = 'nmap <silent>', keys = {'j', 'd'}, action = '<Plug>(coc-definition)', description = 'Definition' },
  { mode = 'nmap <silent>', keys = {'j', 'i'}, action = '<Plug>(coc-implementation)', description = 'Implementation' },
  { mode = 'nmap <silent>', keys = {'j', 'y'}, action = '<Plug>(coc-type-implementation)', description = 'Type definition' },
  { mode = 'nmap <silent>', keys = {'j', 'r'}, action = '<Plug>(coc-references)', description = 'Type references' },
  { mode = 'nnoremap <silent>', keys = {'j', 'e'}, action = '\'\'.', description = 'Last edit' },
  { mode = 'nnoremap <silent>', keys = {'j', 'n'}, action = "<C-o>", description = 'Next jump' },
  { mode = 'nnoremap <silent>', keys = {'j', 'p'}, action = "<C-i>", description = 'Previous jump' },
  { mode = 'nnoremap <silent>', keys = {'j', 'm', 'l'}, action = ':CocList marks<CR>', description = 'List marks' },
  { mode = 'nnoremap', keys = {'j', 'm', 'd'}, action = ':delmarks<Space>', description = 'Delete marks' },
  { mode = 'nnoremap', keys = {'j', 'm', 'm'}, action = '`', description = 'Go to mark' },
  { mode = 'nnoremap', keys = {'j', 'a'}, action = ':A<CR>', description = 'Go to altenate' },
  { mode = 'nnoremap', keys = {'j', 'A'}, action = ':AV<CR>', description = 'Split altenate' },
  -- Search mappings <leader>/
  { mode = 'nnoremap', keys = {'/', 'd'}, action = ':DRg<space>', description = 'Grep files in directory' },
  { mode = 'nnoremap <silent>', keys = {'/', 'c'}, action = ':History:<CR>', description = 'Search command history' },
  { mode = 'nnoremap <silent>', keys = {'/', '/'}, action = ':History/<CR>', description = 'Search history' },
  { mode = 'nnoremap <silent>', keys = {'/', 'i'}, action = ':CocList symbols<CR>', description = 'Search symbol' },
  { mode = 'nnoremap <silent>', keys = {'/', 'l'}, action = ':BLines<CR>', description = 'Search buffer lines' },
  { mode = 'nnoremap <silent>', keys = {'/', 'o'}, action = ':CocList outline<CR>', description = 'List symbols in file' },
  { mode = 'nnoremap <silent>', keys = {'/', 'b'}, action = ':Lines<CR>', description = 'Search lines' },
  { mode = 'nnoremap', keys = {'/', 'p'}, action = ':Rg<space>', description = 'Grep files in project' },
  { mode = 'nnoremap', keys = {'/', 'P'}, action = ':Rg!<space>', description = 'Grep files in project (full },' },
  { mode = 'nnoremap', keys = {'/', 'h'}, action = ':noh<CR>', description = 'Clear searh highlight' },
  { mode = 'nnoremap', keys = {'/', 's'}, action = 'g*N', description = 'Search selected text' },
  { mode = 'vnoremap', keys = {'/', 's'}, action = '"9y/<C-r>9<CR>' },
  { mode = 'nnoremap', keys = {'/', 'S'}, action = ':Rg <C-r><C-w><CR>', description = 'Search selected text (project)' },
  { mode = 'vnoremap', keys = {'/', 'S'}, action = '"9y:Rg <C-r>9<CR>' },
  -- Yank with preview <leader>y
  { mode = 'nnoremap <silent>', keys = {'y', 'l'}, action = ':<C-u>CocList -A --normal yank<CR>', description = 'List yanks' },
  { mode = 'nnoremap <silent>', keys = {'y', 'f'}, action = ':let @" = expand("%:p")<CR>', description = 'Yank file path' },
  { mode = 'nnoremap <silent>', keys = {'y', 'F'}, action = ':let @" = expand("%:t:r")<CR>', description = 'Yank file name' },
  { mode = 'nnoremap <silent>', keys = {'y', 'y'}, action = '"+y', description = 'Yank to clipboard' },
  { mode = 'vnoremap <silent>', keys = {'y', 'y'}, action = '"+y' },
  -- Code mappings <leader>c
  { mode = 'nnoremap <silent>', keys = {'c', 'l'}, action = ':Commentary<CR>', description = 'Comment line' },
  { mode = 'vnoremap', keys = {'c', 'l'}, action = ':Commentary<CR>' },
  { mode = 'nnoremap <silent>', keys = {'c', 'x'}, action = ':CocList diagnostics<CR>', description = 'List diagnostics' },
  { mode = 'nmap <silent>', keys = {'c', 'd'}, action = '<Plug>(coc-definition)', description = 'Definition' },
  { mode = 'nmap <silent>', keys = {'c', 'D'}, action = '<Plug>(coc-references)', description = 'Type references' },
  { mode = 'nmap <silent>', keys = {'c', 'k'}, action = 'gh', description = 'Jump to documenation' },
  { mode = 'nmap <silent>', keys = {'c', 'r'}, action = '<Plug>(coc-rename)', description = 'Rename symbol' },
  { mode = 'nnoremap <silent>', keys = {'c', 'f'}, action = ':CocAction<CR>', description = 'Quick fix actions' },
  -- Documentation mappings <leader>d
  { mode = 'nmap <silent>', keys = {'d', 'd'}, action = '<Plug>(doge-generate)', description = 'Document' },
  -- Git mappings <leader>g
  { mode = 'nnoremap <silent>', keys = {'g', 'c', 'u'}, action = ':CocCommand git.chunkUndo<CR>', description = 'Undo chunk' },
  { mode = 'nnoremap <silent>', keys = {'g', 'c', 's'}, action = ':CocCommand git.chunkStage<CR>', description = 'Stage chunk' },
  { mode = 'nmap <silent>', keys = {'g', 'c', 'n'}, action = '<Plug>(coc-git-nextchunk)', description = 'Next chunk' },
  { mode = 'nmap <silent>', keys = {'g', 'c', 'p'}, action = '<Plug>(coc-git-prevchunk)', description = 'Previous chunk' },
  { mode = 'nmap <silent>', keys = {'g', 'c', 'i'}, action = '<Plug>(coc-git-chunkinfo)', description = 'Chunk info' },
  { mode = 'nnoremap <silent>', keys = {'g', 'B'}, action = ':call luaeval(\'\'steelvim.checkout_git_branch_fzf(_A[0])\'\', [expand("%:p:h")])<CR>', description = 'Checkout branch' },
  { mode = 'nnoremap <silent>', keys = {'g', 's'}, action = ':G<CR>', description = 'Git status' },
  { mode = 'nnoremap <silent>', keys = {'g', 'd'}, action = ':Gdiffsplit<CR>', description = 'Git diff' },
  { mode = 'nnoremap <silent>', keys = {'g', 'e'}, action = ':Gedit<CR>', description = 'Git edit' },
  { mode = 'nnoremap <silent>', keys = {'g', 'g'}, action = ':Git<Space>', description = 'Git command' },
  { mode = 'nnoremap <silent>', keys = {'g', 'l'}, action = ':Commits<CR>', description = 'Git log' },
  { mode = 'nnoremap <silent>', keys = {'g', 'L'}, action = ':BCommits<CR>', description = 'Git file log' },
  { mode = 'nnoremap <silent>', keys = {'g', 'f'}, action = ':Gfetch<CR>', description = 'Git fetch' },
  { mode = 'nnoremap <silent>', keys = {'g', 'p'}, action = ':Gpull<CR>', description = 'Git pull' },
  { mode = 'nnoremap <silent>', keys = {'g', 'P'}, action = ':Gpush<CR>', description = 'Git push' },
  { mode = 'nnoremap <silent>', keys = {'g', 'b'}, action = ':Gblame<CR>', description = 'Git blame' },
  { mode = 'nnoremap <silent>', keys = {'g', 'S'}, action = ':call luaeval(\'\'steelvim.float_fzf_cmd("gss")\'\')<CR>', description = 'Browse stash' },
  { mode = 'nnoremap <silent>', keys = {'g', 'r'}, action = ':call luaeval(\'\'steelvim.float_fzf_cmd("grh")\'\')<CR>', description = 'Reset files to head' },
  { mode = 'nnoremap <silent>', keys = {'g', 'D'}, action = ':call luaeval(\'\'steelvim.float_fzf_cmd("gd")\'\')<CR>', description = 'Diff files' },
  { mode = 'nnoremap <silent>', keys = {'g', 'a'}, action = ':call luaeval(\'\'steelvim.float_fzf_cmd("ga")\'\')<CR>', description = 'Add files' },
  -- Terminal mappings <leader>t
  { mode = 'nnoremap <silent>', keys = {'t', 't'}, action = ':lua steelvim.float_term(false)<CR>', description = 'Float terminal' },
  { mode = 'nnoremap <silent>', keys = {'t', 'T'}, action = ':lua steelvim.float_term(true)<CR>', description = 'Float terminal (full)' },
  { mode = 'nnoremap <silent>', keys = {'t', 'v'}, action = ':vsp <bar> lua steelvim.open_term()<CR>', description = 'Vertical split terminal' },
  { mode = 'nnoremap <silent>', keys = {'t', 'f'}, action = ':vsp <bar> lua steelvim.open_term(true)<CR>', description = 'Terminal at file' }
}

local function get_which_key_mappings()
  return {
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
    j = { name = '+jump', m = { name = '+marks' } },
    t = { name = '+terminal' }
  }
end

local function register_leader_mappings(which_key_map)
  vim.api.nvim_set_var(which_key_map, get_which_key_mappings())
  steelvim.define_leader_mappings(which_key_map, leader_mappings)
end

return {
  register_leader_mappings = register_leader_mappings,
  get_which_key_mappings = get_which_key_mappings
}
