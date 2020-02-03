local nvim = require 'nvim'

local function flygrep(query, cwd, fullscreen)
  local command = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  local initial_cmd = command:format(nvim.fn.shellescape(query))
  local reload_cmd = command:format('{q}')
  local spec = {
    dir = cwd,
    options = { '--phony', '--query', query, '--bind', ('change:reload:%s'):format(reload_cmd) }
  }

  if fullscreen == 1 then
    nvim.fn['fzf#vim#grep'](initial_cmd, 1, nvim.fn['fzf#vim#with_preview'](spec, 'up:80%'), 1)
  else
    nvim.fn['fzf#vim#grep'](initial_cmd, 1, nvim.fn['fzf#vim#with_preview'](spec), 0)
  end
end

local function grep(query, dir, fullscreen)
  local options

  if fullscreen == 1 then
    options = nvim.fn['fzf#vim#with_preview']({ dir = dir }, 'up:80%')
  else
    options = nvim.fn['fzf#vim#with_preview']({ dir = dir }, 'right:50%', '?')
  end

  nvim.fn['fzf#vim#grep'](
    ('rg --column --line-number --no-heading --color=always --smart-case %s'):format(nvim.fn.shellescape(query)),
    1,
    options,
    fullscreen
  )
end

return {
  flygrep = flygrep,
  grep = grep
}
