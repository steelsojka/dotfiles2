local Observable = require 'utils/observable'
local Funcref = require 'utils/funcref'
local Subject = require 'utils/subject'
local uv = vim.loop

local M = {}

function M.job_start(cmd, options)
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local stdin = uv.new_pipe(false)
  local result_source = Subject:create()
  local data = {}
  local errors = {}
  local source = {}

  function source:next(v) uv.write(stdin, v) end
  function source:subscribe(subscriber) return result_source:subscribe(subscriber) end
  function source:complete() return uv.close(stdin) end

  setmetatable(source, { __index = Subject:create() })

  uv.read_start(stdout, function(err, chunk)
    if chunk then
      table.insert(data, chunk)
    end
  end)

  uv.read_start(stderr, function(err, chunk)
    if chunk then
      table.insert(errors, chunk)
    end
  end)

  local handle, pid = uv.spawn(cmd, {
    stdio = { stdin, stdout, stderr },
    cwd = vim.fn.getcwd()
  }, function(code, signal)
    print(code, signal)
    stdio:close()
    stderr:close()
    stdout:close()
    handle:close()

    if code == 0 and signal == 0 then
      result_source:next(data)
      result_source:complete()
    else
      result_source:error(errors)
    end
  end)

  return source
end

return M
