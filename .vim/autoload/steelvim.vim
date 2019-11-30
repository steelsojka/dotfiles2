function! steelvim#delete_qf_items(bufnr) range
  call luaeval('steelvim.delete_qf_item(_A[1], _A[2])', [a:firstline, a:lastline])
endfunction
