local nvim = require 'nvim'
local utils = require 'utils'
local Fzf = require 'fzf/fzf'

local git_checkout_fzf = Fzf:create '!git checkout'

steelvim = {
  -- Opens terminal to the cwd or to the current files directory.
  -- @param is_local Whether to open local to the current file directory
  open_term = function(is_local)
    local cwd = is_local and nvim.fn.expand '%:p:h' or nvim.fn.getcwd()
    local buf = nvim.create_buf(true, false)

    nvim.set_current_buf(buf)
    nvim.fn.termopen(nvim.o.shell, { cwd = cwd })
    nvim.ex.normal 'i'
  end,

  -- Opens a terminl with an fzf floating window
  -- @param The command to run
  float_fzf_cmd = function(cmd)
    Fzf.create_floating_window()
    -- Open a term and exit on process exit
    nvim.command('call termopen(\'' .. cmd .. '\', {\'on_exit\': {_ -> execute(\'q!\') }})')
    nvim.ex.normal 'i'
  end,

  -- Checks out a git branch using fzf
  -- @param dir The directory to run fzf in
  checkout_git_branch_fzf = function(dir)
    git_checkout_fzf:execute {
      source = 'git lob', 
      window = Fzf.float_window(),
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
    nvim.ex.normal 'i'
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

  -- Starts which key.
  -- This will set local buffer mapping names to the local key "m"
  -- @param visual Whether visual mode
  start_which_key = function(visual)
    local success, local_which_key_dict = pcall(function() return nvim.b.local_which_key end)
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

  -- Prompts for input to a command
  -- @param command Command to run with search term
  -- @param prompt Prompt text
  prompt_command = function(command, prompt)
    local search_term = nvim.fn.input(prompt .. ': ')

    if string.len(search_term) > 0 then
      nvim.command(command .. ' ' .. search_term)
    end
  end,

  get_git_status = function()
    local status = nvim.fn['fugitive#head']()

    if nvim.fn.winwidth(0) > 80 then
      return status:len() > 30 and (status:sub(0, 27) .. '...') or status
    end
    
    return ''
  end,

  show_documentation = function()
    if nvim.fn.index({ 'vim', 'lua', 'help' }, nvim.bo.filetype) >= 0 then
      nvim.ex.help(nvim.fn.expand('<cword>'))
    else
      nvim.fn.CocAction('doHover')
    end
  end,

  build_quickfix_list = function(lines)
    nvim.fn.setqflist(utils.map(lines, function(line) return { filename = line } end))
    nvim.ex.copen()
    nvim.ex.cc()
  end,

  flygrep = function(query, cwd, fullscreen)
    local command = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    local initial_cmd = nvim.fn.printf(command, nvim.fn.shellescape(query))
    local reload_cmd = nvim.fn.printf(command, '{q}')
    local spec = {
      dir = cwd,
      options = { '--phony', '--query', query, '--bind', 'change:reload:' .. reload_cmd }
    }

    nvim.fn['fzf#vim#grep'](initial_cmd, 1, nvim.fn['fzf#vim#with_preview'](spec), fullscreen)
  end
} 

setmetatable(steelvim, {
  __index = steelvim
})
