local leader_mappings = {
  { mode = 'nnoremap', keys = {','}, action = ':Buffers<CR>', description = 'Switch buffer' },
  { mode = 'nnoremap', keys = {'.'}, action = ':Files<CR>', description = 'Find files' },
  { mode = 'nnoremap', keys = {"<Space>"}, action = ':Commands<CR>^' },
  -- File mappings <leader>f
  { mode = 'nnoremap <silent>', keys = {'f', 's'}, action = ':w<CR>', description = 'Save file' },
  { mode = 'nnoremap <silent>', keys = {'f', 'S'}, action = ':wa<CR>', description = 'Save all files' },
  { mode = 'nnoremap <silent>', keys = {'f', '/'}, action = ':BLines<CR>', description = 'Search lines' },
  { mode = 'nnoremap <silent>', keys = {'f', 'f'}, action = ':call CocAction("format" },<CR>', description = 'Format file' },
  { mode = 'nnoremap <silent>', keys = {'f', 'o'}, action = ':Dirvish %:p:h<CR>', description = 'Show in tree' },
  { mode = 'nnoremap <silent>', keys = {'f', 'O'}, action = ':vsp +Dirvish %:p:h<CR>', description = 'Show in split tree' },
  { mode = 'nnoremap <silent>', keys = {'f', 'r'}, action = ':CocList mru<CR>', description = 'Open recent files' },
  { mode = 'nnoremap <silent>', keys = {'f', 'u'}, action = ':UndotreeToggle<CR>', description = 'Undo tree' },
  { mode = 'nnoremap <silent>', keys = {'f', 'U'}, action = ':UndotreeFocus<CR>', description = 'Focus undo tree' },
  { mode = 'nnoremap <silent>', keys = {'f', 'E'}, action = ':vsp $MYVIMRC<CR>', description = 'Edit .vimrc' },
  -- Buffer mappings <leader>b
  { mode = 'nnoremap <silent>', keys = {'b', 'p'}, action = ':bprevious<CR>', description = 'Previous buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'n'}, action = ':bnext<CR>', description = 'Next buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'f'}, action = ':bfirst<CR>', description = 'First buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'l'}, action = ':blast<CR>', description = 'Last buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'd'}, action = ':bp<CR>:bd#<CR>', description = 'Delete buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'k'}, action = ':bp<CR>:bw!#<CR>', description = 'Wipe buffer' },
  { mode = 'nnoremap <silent>', keys = {'b', 'b'}, action = ':Buffers<CR>', description = 'List buffers' },
  { mode = 'nnoremap <silent>', keys = {'b', 'Y'}, action = 'ggyG', description = 'Yank buffer' }
}

return {
  register_leader_mappings = function()
    steelvim.define_leader_mappings('which_key_map', leader_mappings)
  end
}
