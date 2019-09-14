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

function! steelvim#checkout_git_branch_fzf(dir) abort
   call fzf#run({ 'source': "git branch | awk '!/*/{print $1}'", 'sink': '!git checkout', 'down': '30%', 'dir': a:dir })
endfunction
