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
        \ 'source': luaeval('steelvim.get_qf_fzf_list(_A[1])', [s:to_boolean(a:new_list)]),
        \ 'sink*': function('s:handle_fzf_qf_filter', [a:new_list]), 
        \ 'window': 'lua steelvim.float_fzf()',
        \ 'options': ['--multi']
        \ })
endfunction

function! steelvim#delete_qf_items(bufnr) range
  call luaeval('steelvim.delete_qf_item(_A[1], _A[2])', [a:firstline, a:lastline])
endfunction

function! s:handle_fzf_qf_filter(new_list, lines)
  call luaeval('steelvim.handle_fzf_qf_filter(_A[1], _A[2])', [s:to_boolean(a:new_list), a:lines])
endfunction

function s:to_boolean(value)
  return a:value ? v:true : v:false 
endfunction
