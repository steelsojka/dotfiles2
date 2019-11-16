local nvim = require 'nvim'
local utils = require 'utils'

steelvim = {
  -- Opens terminal to the cwd or to the current files directory.
  -- @param is_local Whether to open local to the current file directory
  open_term = function(is_local)
    local cwd = is_local and nvim.fn.expand('%:p:h') or nvim.fn.getcwd()
    local buf = nvim.create_buf(true, false)

    nvim.set_current_buf(buf)
    nvim.fn.termopen(nvim.o.shell, { cwd = cwd })
    nvim.ex.normal('i')
  end,

  -- Creates a floating window for FZF
  float_fzf = function()
    local buf = nvim.create_buf(false, true)
    local columns = nvim.o.columns
    local lines = nvim.o.lines
    local width = math.floor(columns - (columns * 2 / 10))
    local height = lines - 3
    local y = height
    local x = math.floor((columns - width) / 2)

    nvim.fn.setbufvar(buf, '&signcolumn', 'no' )
    nvim.open_win(buf, true, { relative = 'editor', row = y, col = x, width = width, height = height })
    nvim.ex.setlocal('winblend=10')
  end,

  float_fzf_cmd = function(cmd)
    steelvim.float_fzf()
    -- Open a term and exit on process exit
    nvim.command('call termopen(\'' .. cmd .. '\', {\'on_exit\': {_ -> execute(\'q!\') }})')
    nvim.ex.normal('i')
  end,

  -- Checks out a git branch using fzf
  -- @param dir The directory to run fzf in
  checkout_git_branch_fzf = function(dir)
    nvim.fn['fzf#run'] { 
      source = 'git lob', 
      sink = '!git checkout', 
      window = 'lua steelvim.float_fzf()', 
      dir = dir 
    }
  end,

  -- Opens a floating terminal
  -- @param full Whether the terminal is full screen
  float_term = function(full)
    local height

    if full then
      height = nvim.fn.winheight(0)
    else
      local lines = nvim.o.lines
      height = math.floor(lines * 0.6)
    end

    nvim.g.floaterm_height = height
    nvim.ex.FloatermToggle()
    nvim.ex.normal('i')
  end,

  -- Gets lines from the current quickfix list for fzf to filter
  -- @param new_list Whether to create a new quickfix list
  get_qf_fzf_list = function(new_list)
    local qf_list = nvim.fn.getqflist()

    return utils.map(
      qf_list, 
      function(item, i)
        return i .. '|' .. nvim.buf_get_name(item.bufnr) .. '|' .. item.lnum .. ' col ' .. item.col .. '| ' .. item.text
      end
    ) 
  end,

  -- Handles lines from the quickfix filter list
  -- @param new_list Whether to create a new quickfix list
  -- @param lines The selected lines
  handle_fzf_qf_filter = function(new_list, lines)
    local qf_list = nvim.fn.getqflist()
    local rows_to_keep = utils.map(lines, function(line) return string.sub(line, 1, 1) end)
    local new_results = utils.filter(qf_list, function(item, i) return vim.tbl_contains(rows_to_keep, tostring(i)) end)

    if new_list then
      nvim.fn.setqflist(new_results)
    else
      nvim.fn.setqflist({}, 'r', { items = new_results })
    end
  end,

  -- Deletes items in the quickfix list
  -- @param firstline 
  -- @param lastline
  delete_qf_item = function(firstline, lastline)
    local qf_list = nvim.fn.getqflist()
    local i = firstline
    
    while i <= lastline do
      table.remove(qf_list, firstline)
      i = i + 1
    end

    nvim.fn.setqflist({}, 'r', { items = qf_list })
  end,

  execute_mapping = function(mode, keys, action)
    nvim.ex.execute([[']] .. mode .. utils.join(keys, '') .. ' ' .. action .. [[']])
  end,

  define_mapping = function(mode, keys, action, description, key_dict)
    steelvim.execute_mapping(mode, keys, action) 

    local category = key_dict
    local category_keys = {unpack(keys, 1, #keys - 1)}
    local end_key = keys[#keys]

    for i,key in ipairs(category_keys) do
      category = category[key]
    end

    category[end_key] = description
  end,

  define_leader_mapping = function(mode, keys, action, description, which_key_dict)
    if which_key_dict then
      steelvim.define_mapping(mode .. ' <leader>', keys, action, description, which_key_dict)
    else
      steelvim.execute_mapping(mode .. ' <leader>', keys, action)
    end
  end,

  define_leader_mappings = function(dict, defs)
    for i,def in ipairs(defs) do
      steelvim.define_leader_mapping(def.mode, def.keys, def.action, def.description, def.description and dict or nil)
    end
  end,

  define_local_leader_mappings = function(defs)
    local dict = { m = {} }
    local buf = nvim.win_get_buf(0)

    for i,def in ipairs(defs) do
      steelvim.define_leader_mapping(def.mode, def.keys, def.action, def.description, def.description and dict or nil)
    end

    nvim.buf_set_var(buf, 'local_which_key', dict)
  end,

  start_which_key = function(visual)
    local buf = nvim.win_get_buf(0)
    local success, local_which_key_dict = pcall(function() return nvim.buf_get_var(buf, 'local_which_key') end)
    local which_key_dict = nvim.g.which_key_map

    which_key_dict['m'] = { name = '+local' }

    if success then
      which_key_dict['m'] = local_which_key_dict['m']
      which_key_dict['m'].name = '+local'
    end

    nvim.g.which_key_map = which_key_dict
    nvim.fn['which_key#register']('<Space>', 'g:which_key_map')
    nvim.command((visual and 'WhichKeyVisual' or 'WhichKey') .. ' " "')
  end,

  rg_input = function(command, prompt)
    local search_term = nvim.fn.input(prompt .. ': ')

    if string.len(search_term) > 0 then
      nvim.command(command .. ' ' .. search_term)
    end
  end
} 

setmetatable(steelvim, {
  __index = steelvim
})
