local M = {}

-- Gets the project root folder based on contents of the parent directory
function M.get_project_root(path, matcher)
  local path_parts = steel.fn.split(path, '/')
  local _matcher = matcher or function(file) return file == '.git' end

  while #path_parts > 0 do
    local dir = '/' .. steel.fn.join(path_parts, '/')
    local files = steel.fs.readdir(dir)

    for _, file in pairs(files) do
      if _matcher(file, files, dir) then
        return dir
      end
    end

    table.remove(path_parts)
  end

  return nil
end

-- Creates a local folder in the project root.
function M.create_project_local(path, folder_name, matcher)
  local root = M.get_project_root(path, matcher) or vim.fn.expand('~')
  local local_folder = root .. '/' .. (folder_name or '.local')

  if (not steel.fs.isdir(local_folder)) then
    os.execute('mkdir ' .. local_folder)
  end

  return local_folder
end

function M.cd_to_root(path, matcher)
  path = path or vim.fn.getcwd()

  local root = M.get_project_root(path, matcher)

  if root then
    steel.ex.cd(root)
  end
end

return M
