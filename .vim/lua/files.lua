local nvim = require 'nvim'
local project = require 'utils/project'

local function fzf_files(query, fullscreen)
  local local_folder = project.create_project_local(nvim.fn.expand('%:p:h'))
  local spec = {
    options = {
      '--history', local_folder .. '/fzf-history-files'
    }
  }

  print(local_folder)

  if fullscreen == 1 then
    nvim.fn['fzf#vim#files'](query, nvim.fn['fzf#vim#with_preview'](spec, 'up:80%'), 1)
  else
    nvim.fn['fzf#vim#files'](query, nvim.fn['fzf#vim#with_preview'](spec), 0)
  end
end

return {
  fzf_files = fzf_files
}
