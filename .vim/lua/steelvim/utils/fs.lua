local M = {}

function M.exists(file)
  local ok, err, code = os.rename(file, file)

  if not ok then
    if code == 13 then return true end
  end

  return ok, err
end

function M.isdir(path)
  return M.exists(path .. '/')
end

function M.exec(prog)
  local i = 0
  local result = {}

  local pfile = io.popen(prog)

  for filename in pfile:lines() do
    i = i + 1
    result[i] = filename
  end

  pfile:close()

  return result
end

function M.readdir(path)
  return M.exec('ls -a "' .. path .. '"')
end


return M
