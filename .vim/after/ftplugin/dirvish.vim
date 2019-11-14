setlocal nospell

nmap <silent><buffer> K <Plug>(dirvish_up)
nmap <buffer> <leader>q gq
nmap <buffer> <leader>Q gq

lua << EOF
steelvim.define_local_leader_mappings({
  { mode = 'nnoremap <silent><buffer>', keys = {'m', 'd'}, action = ':!mkdir %', description = 'Make directory' },
  { mode = 'nnoremap <buffer>', keys = {'m', 'f'}, action = ':!touch %', description = 'Create file' },
  { mode = 'nnoremap <buffer>', keys = {'m', 'r'}, action = '"9yy:!mv <c-r>9 %', description = 'Rename' },
  { mode = 'nnoremap <buffer>', keys = {'m', 'c'}, action = '"9yy:!cp <c-r>9 %', description = 'Copy' },
  { mode = 'nnoremap <buffer>', keys = {'m', 'k'}, action = '"9yy:!rm -r <c-r>9', description = 'Delete' }
})
EOF
