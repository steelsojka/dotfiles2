local nvim = require 'nvim'
local utils = require 'utils/utils'
local project = require 'utils/project'

local function flygrep(query, cwd, fullscreen, args)
  local local_folder = project.create_project_local(nvim.fn.expand('%:p:h'))
  local custom_args = utils.join(args or {}, ' ')
  local command = 'rg --column --line-number --no-heading --color=always --smart-case %s %s || true'
  local initial_cmd = command:format(custom_args, nvim.fn.shellescape(query))
  local reload_cmd = command:format(custom_args, '{q}')
  local spec = {
    dir = cwd,
    options = { 
      '--phony', 
      '--query', query, 
      '--bind', ('change:reload:%s'):format(reload_cmd),
      '--history', local_folder .. '/fzf-history-grep'
    }
  }

  if fullscreen == 1 then
    nvim.fn['fzf#vim#grep'](initial_cmd, 1, nvim.fn['fzf#vim#with_preview'](spec, 'up:80%'), 1)
  else
    nvim.fn['fzf#vim#grep'](initial_cmd, 1, nvim.fn['fzf#vim#with_preview'](spec), 0)
  end
end

local function grep(query, dir, fullscreen, args)
  local options
  local custom_args = utils.join(args or {}, ' ')

  if fullscreen == 1 then
    options = nvim.fn['fzf#vim#with_preview']({ dir = dir }, 'up:80%')
  else
    options = nvim.fn['fzf#vim#with_preview']({ dir = dir }, 'right:50%', '?')
  end

  nvim.fn['fzf#vim#grep'](
    ('rg --column --line-number --no-heading --color=always --smart-case %s %s'):format(custom_args, nvim.fn.shellescape(query)),
    1,
    options,
    fullscreen
  )
end

local function grep_quickfix_files()
  local qf_list = nvim.fn.getqflist()
end

return {
  flygrep = flygrep,
  grep = grep
}
