local function readdir(path)
  local i = 0
  local result = {}

  local pfile = io.popen('ls -a "' .. path .. '"')

  for filename in pfile:lines() do
    i = i + 1
    result[i] = filename
  end

  pfile:close()

  return result
end

local function exists(file)
  local ok, err, code = os.rename(file, file)

  if not ok then
    if code == 13 then return true end
  end

  return ok, err
end

local function isdir(path)
  return exists(path .. '/')
end

return {
  readdir = readdir,
  exists = exists,
  isdir = isdir
}
