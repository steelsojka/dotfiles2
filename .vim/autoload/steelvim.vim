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
  call fzf#run({ 'source': "git lob", 'sink': '!git checkout', 'window': 'call steelvim#float_fzf()', 'dir': a:dir })
endfunction

function! steelvim#start_slime_session(command, filetype) abort
  let current_buffer_name = bufname('%')
  let current_window = winnr()
  let buf_name = bufadd(current_buffer_name . '.slime-sesson')

  execute 'silent' 'vsp' buf_name
  execute 'silent' 'set filetype=' . a:filetype

  let job_id = termopen(a:command)
  execute 'silent' current_window . 'wincmd w'
  let b:slime_config = { "jobid": job_id }

  if (job_id <= 0)
    echo 'Failed to create slime job.'
  endif
endfunction

function! steelvim#get_startify_banner() abort
  return [
        \'                                 __                ',
        \'    ___      __    ___   __  __ /\_\    ___ ___    ',
        \'  /'' _ `\  /''__`\ / __`\/\ \/\ \\/\ \ /'' __` __`\  ',
        \'  /\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ',
        \'  \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\',
        \'   \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/',
        \'                                      Steel Edition',
        \]
endfunction

function! steelvim#float_term(full) abort
  let g:floaterm_height = a:full ? winheight(0) : winheight(0) / 2

  execute 'FloatermToggle'
  normal i
endfunction

function! steelvim#float_fzf()
  let buf = nvim_create_buf(v:false, v:true)

  call setbufvar(buf, '&signcolumn', 'no')

  let width = float2nr(&columns - (&columns * 2 / 10))
  let height = &lines - 3
  let y = &lines - 3
  let x = float2nr((&columns - width) / 2)

  let opts = {
       \ 'relative': 'editor',
       \ 'row': y,
       \ 'col': x,
       \ 'width': width,
       \ 'height': height
       \ }

  call nvim_open_win(buf, v:true, opts)
  setlocal winblend=10
endfunction
