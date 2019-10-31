let &l:makeprg = g:typescript_compiler_binary . ' ' . g:typescript_compiler_options . ' $*'

nnoremap <silent><buffer> <leader>mc :Make -p tsconfig.json<CR>
nnoremap <silent><buffer> <leader>mi :call steelvim#start_slime_session('ts-node -T', 'typescript')<CR>
