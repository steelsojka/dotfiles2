local utils = require('utils')

steelvim = {
  -- Opens terminal to the cwd or to the current files directory.
  -- @param is_local Whether to open local to the current file directory
  open_term = function(is_local)
    local cwd = is_local 
      and vim.api.nvim_call_function('expand', { '%:p:h' })
      or vim.api.nvim_call_function('getcwd', {})

    local buf = vim.api.nvim_create_buf(true, false)

    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_call_function('termopen', { vim.api.nvim_get_option('shell'), { cwd = cwd } })
    vim.api.nvim_command('normal i')
  end,

  -- Creates a floating window for FZF
  float_fzf = function()
    local buf = vim.api.nvim_create_buf(false, true)
    local columns = vim.api.nvim_get_option('columns')
    local lines = vim.api.nvim_get_option('lines')
    local width = math.floor(columns - (columns * 2 / 10))
    local height = lines - 3
    local y = height
    local x = math.floor((columns - width) / 2)

    vim.api.nvim_call_function('setbufvar', { buf, '&signcolumn', 'no' })
    vim.api.nvim_open_win(buf, true, { relative = 'editor', row = y, col = x, width = width, height = height })
    vim.api.nvim_command('setlocal winblend=10')
  end,

  -- Checks out a git branch using fzf
  -- @param dir The directory to run fzf in
  checkout_git_branch_fzf = function(dir)
    vim.api.nvim_call_function('fzf#run', {
      { 
        source = 'git lob', 
        sink = '!git checkout', 
        window = 'lua steelvim.float_fzf()', 
        dir = dir 
      }
    })
  end,

  -- Opens a floating terminal
  -- @param full Whether the terminal is full screen
  float_term = function(full)
    local height

    if full then
      height = vim.api.nvim_call_function('winheight', { 0 })
    else
      local lines = vim.api.nvim_get_option('lines')
      height = math.floor(lines * 0.6)
    end

    vim.api.nvim_set_var('floaterm_height', height)
    vim.api.nvim_command('FloatermToggle')
    vim.api.nvim_command('normal i')
  end,

  -- Gets lines from the current quickfix list for fzf to filter
  -- @param new_list Whether to create a new quickfix list
  get_qf_fzf_list = function(new_list)
    local qf_list = vim.api.nvim_call_function('getqflist', {})

    return utils.map(
      qf_list, 
      function(item, i)
        return i .. '|' .. vim.api.nvim_buf_get_name(item.bufnr) .. '|' .. item.lnum .. ' col ' .. item.col .. '| ' .. item.text
      end
    ) 
  end,

  -- Handles lines from the quickfix filter list
  -- @param new_list Whether to create a new quickfix list
  -- @param lines The selected lines
  handle_fzf_qf_filter = function(new_list, lines)
    local qf_list = vim.api.nvim_call_function('getqflist', {})
    local rows_to_keep = utils.map(lines, function(line) return string.sub(line, 1, 1) end)
    local new_results = utils.filter(qf_list, function(item, i) return vim.tbl_contains(rows_to_keep, tostring(i)) end)

    if new_list then
      vim.api.nvim_call_function('setqflist', { new_results })
    else
      vim.api.nvim_call_function('setqflist', { {}, 'r', { items = new_results } })
    end
  end,

  -- Deletes items in the quickfix list
  -- @param firstline 
  -- @param lastline
  delete_qf_item = function(firstline, lastline)
    local qf_list = vim.api.nvim_call_function('getqflist', {})
    local i = firstline
    
    while i <= lastline do
      table.remove(qf_list, firstline)
      i = i + 1
    end

    vim.api.nvim_call_function('setqflist', { {}, 'r', { items = qf_list } })
  end
} 

setmetatable(steelvim, {
  __index = steelvim
})
