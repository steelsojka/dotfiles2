local utils = require 'steelvim/utils/utils'
local project = require 'steelvim/utils/project'

local M = {}

function M.flygrep(query, cwd, fullscreen, args)
  local local_folder = project.create_project_local(vim.fn.expand('%:p:h'))
  local custom_args = utils.join(args or {}, ' ')
  local command = 'rg --column --line-number --no-heading --color=always --smart-case %s %s || true'
  local initial_cmd = command:format(custom_args, vim.fn.shellescape(query))
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
    vim.fn['fzf#vim#grep'](initial_cmd, 1, vim.fn['fzf#vim#with_preview'](spec, 'up:80%'), 1)
  else
    vim.fn['fzf#vim#grep'](initial_cmd, 1, vim.fn['fzf#vim#with_preview'](spec), 0)
  end
end

function M.grep(query, dir, fullscreen, args)
  local options
  local custom_args = utils.join(args or {}, ' ')

  if fullscreen == 1 then
    options = vim.fn['fzf#vim#with_preview']({ dir = dir }, 'up:80%')
  else
    options = vim.fn['fzf#vim#with_preview']({ dir = dir }, 'right:50%', '?')
  end

  vim.fn['fzf#vim#grep'](
    ('rg --column --line-number --no-heading --color=always --smart-case %s %s'):format(custom_args, vim.fn.shellescape(query)),
    1,
    options,
    fullscreen
  )
end

return M
