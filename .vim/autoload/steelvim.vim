function! steelvim#define_mapping(mode, keys, action, description, which_key_dict) abort
  call steelvim#execute_mapping(a:mode, a:keys, a:action) 
  let category = a:which_key_dict
  let category_keys = a:keys[:-2]
  let end_key = a:keys[-1:][0]

  for key in category_keys
    let category = category[key]
  endfor

  let category[end_key] = a:description
endfunction

function! steelvim#define_leader_mapping(mode, keys, action, description, ...) abort
  let ignore_which_key = get(a:, 0, 0)

  if ignore_which_key
    call steelvim#execute_mapping(a:mode . ' <leader>', a:keys, a:action)
  else
    call steelvim#define_mapping(a:mode . ' <leader>', a:keys, a:action, a:description, g:which_key_map)
  endif
endfunction

function! steelvim#execute_mapping(mode, keys, action) abort
  execute a:mode . join(a:keys, '') . ' ' . a:action
endfunction

function! steelvim#get_startify_banner() abort
  return [
        \'                                 __                ',
        \'    ___      __    ___   __  __ /\_\    ___ ___    ',
        \'  /'' _ `\  /''__`\ / __`\/\ \/\ \\/\ \ /'' __` __`\  ',
        \'  /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ',
        \'  \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\',
        \'   \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/',
        \'                                      Steel Edition',
        \]
endfunction

function! steelvim#filter_qf(new_list)
  call fzf#run({
        \ 'source': map(getqflist(), {i, val -> i . '|' . bufname(val.bufnr) . '|' . val.lnum . ' col ' . val.col . '| ' . val.text }),
        \ 'sink*': function('s:populate_fzf_qf', [a:new_list]), 
        \ 'window': 'lua steelvim.float_fzf()',
        \ 'options': ['--multi']
        \ })
endfunction

function! steelvim#delete_qf_items(bufnr) range
  let list = getqflist()
  
  call remove(list, a:firstline - 1, a:lastline - 1)
  call setqflist([], 'r', { 'items': list })
  call setpos('.', [a:bufnr, a:firstline, 1, 0])
endfunction

function! s:populate_fzf_qf(new_list, lines)
  let rows_to_keep = map(a:lines, {_, val -> strpart(val, 0, 1)})
  let qf_list = filter(getqflist(), {i -> index(rows_to_keep, string(i)) != -1})

  if a:new_list == 1
    call setqflist(qf_list)
  else
    call setqflist([], 'r', { 'items': qf_list })
  endif
endfunction

