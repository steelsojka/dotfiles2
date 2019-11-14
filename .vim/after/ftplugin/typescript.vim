let &l:makeprg = g:typescript_compiler_binary . ' ' . g:typescript_compiler_options . ' $*'

lua << EOF
steelvim.define_local_leader_mappings({
  { mode = 'nnoremap <silent><buffer>', keys = {'m', 'c'}, action = ':Make -p tsconfig.json<CR>', description = 'Compile' }
})
EOF
" nnoremap <silent><buffer> <leader>mc :Make -p tsconfig.json<CR>

