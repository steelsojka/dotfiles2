local nvim = require 'nvim'

local function flygrep(query, cwd, fullscreen)
  local command = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  local initial_cmd = nvim.fn.printf(command, nvim.fn.shellescape(query))
  local reload_cmd = nvim.fn.printf(command, '{q}')
  local spec = {
    dir = cwd,
    options = { '--phony', '--query', query, '--bind', 'change:reload:' .. reload_cmd }
  }

  nvim.fn['fzf#vim#grep'](initial_cmd, 1, nvim.fn['fzf#vim#with_preview'](spec), fullscreen)
end

local function grep(query, dir, fullscreen)
  local options

  if fullscreen == 1 then
    options = nvim.fn['fzf#vim#with_preview']({ dir = dir }, 'up:60%')
  else
    options = nvim.fn['fzf#vim#with_preview']({ dir = dir }, 'right:50%', '?')
  end

  nvim.fn['fzf#vim#grep'](
    'rg --column --line-number --no-heading --color=always --smart-case ' .. nvim.fn.shellescape(query),
    1,
    options,
    fullscreen
  )
end

return {
  flygrep = flygrep,
  grep = grep
}
