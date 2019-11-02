nnoremap <silent><buffer> <leader>mn :cnewer<CR>
nnoremap <silent><buffer> <leader>mp :colder<CR>
nnoremap <silent><buffer> <leader>ml :chistory<CR>
nnoremap <silent><buffer> <leader>mf :call steelvim#filter_qf(0)<CR>
nnoremap <silent><buffer> <leader>mF :call steelvim#filter_qf(1)<CR>
nnoremap <silent><buffer> <leader>md :call steelvim#delete_qf_items(bufnr())<CR>
vnoremap <silent><buffer> <leader>md :call steelvim#delete_qf_items(bufnr())<CR>
