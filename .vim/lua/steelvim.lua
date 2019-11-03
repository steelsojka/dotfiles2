-- Opens terminal to the cwd or to the current files directory.
-- @param is_local Whether to open local to the current file directory
function steelvim_open_term(is_local)
  if is_local then 
    cwd = vim.api.nvim_call_function('expand', { '%:p:h' })
  else
    cwd = vim.api.nvim_call_function('getcwd', {})
  end

  buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_call_function('termopen', { vim.api.nvim_eval('&shell'), { cwd = cwd } })
  vim.api.nvim_command('normal i')
end

-- Creates a floating window for FZF
function steelvim_float_fzf()
  buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_call_function('setbufvar', { buf, '&signcolumn', 'no' })

  columns = vim.api.nvim_eval('&columns')
  lines = vim.api.nvim_eval('&lines')
  width = math.floor(columns - (columns * 2 / 10))
  height = lines - 3
  y = height
  x = math.floor((columns - width) / 2)

  vim.api.nvim_open_win(buf, true, { relative = 'editor', row = y, col = x, width = width, height = height })
  vim.api.nvim_command('setlocal winblend=10')
end

-- Checks out a git branch using fzf
-- @param dir The directory to run fzf in
function steelvim_checkout_git_branch_fzf(dir)
  vim.api.nvim_call_function('fzf#run', {
    { 
      source = 'git lob', 
      sink = '!git checkout', 
      window = 'lua steelvim_float_fzf()', 
      dir = dir 
    }
  })
end

-- Opens a floating terminal
-- @param full Whether the terminal is full screen
function steelvim_float_term(full)
  if full then
    height = vim.api.nvim_call_function('winheight', { 0 })
  else
    lines = vim.api.nvim_eval('&lines')
    height = math.floor(lines * 0.6)
  end

  vim.api.nvim_command('let g:floaterm_height = ' .. height)
  vim.api.nvim_command('FloatermToggle')
  vim.api.nvim_command('normal i')
end
