local nvim = require 'nvim'
local utils = require 'utils/utils'
local fs = require 'utils/fs'

-- Gets the project root folder based on contents of the parent directory
local function get_project_root(path, matcher)
  local path_parts = utils.split(path, '/')
  local _matcher = matcher or function(file) return file == '.git' end

  while #path_parts > 0 do
    local dir = '/' .. utils.join(path_parts, '/')
    local files = fs.readdir(dir)

    for i, file in pairs(files) do
      if _matcher(file, files, dir) then
        return dir
      end
    end

    table.remove(path_parts)
  end

  return nil
end

-- Creates a local folder in the project root.
local function create_project_local(path, folder_name, matcher)
  local root = get_project_root(path, matcher) or nvim.fn.expand('~')
  local local_folder = root .. '/' .. (folder_name or '.local')
  
  if (not fs.isdir(local_folder)) then
    os.execute('mkdir ' .. local_folder)
  end

  return local_folder
end

return {
  get_project_root = get_project_root,
  create_project_local = create_project_local
}
