setlocal nospell

nmap <silent><buffer> K <Plug>(dirvish_up)
nnoremap <buffer> <leader>md :!mkdir %
nnoremap <buffer> <leader>mf :!touch %
nnoremap <buffer> <leader>mr "9yy:!mv <c-r>9 %
nnoremap <buffer> <leader>mc "9yy:!cp <c-r>9 % 
nnoremap <buffer> <leader>mk "9yy:!rm -r <c-r>9
nmap <buffer> <leader>q gq
nmap <buffer> <leader>Q gq
