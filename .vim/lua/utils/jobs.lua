local Observable = require 'utils/observable'
local Funcref = require 'utils/funcref'

local M = {}

local function is_eof(list)
  return type(list) == 'table' and list[1] == "" and list[2] == nil
end

function M.job_start(cmd, stdin_handler)
  return Observable:create(function(subscriber)
    local result = {}
    local handler = Funcref:create(function(_, _, data, event)
      if event == 'stdout' then
        if is_eof(data) then
          subscriber.next(result)
        else
          for _,v in pairs(data) do
            table.insert(result, v)
          end
        end
      elseif event == 'stderr' and not is_eof(data) then
        subscriber.error(data)
      elseif event == 'exit' then
        subscriber.complete()
      end
    end)

    local job_id = vim.fn.eval(([[jobstart('%s', { 'on_stdout': %s, 'on_stderr': %s, 'on_exit': %s })]]):format(
      cmd,
      handler:get_vim_ref_string(),
      handler:get_vim_ref_string(),
      handler:get_vim_ref_string()
    ))

    if type(stdin_handler) == 'function' then
      stdin_handler(job_id)
    elseif stdin_handler then
      vim.fn.chansend(job_id, stdin_handler)
      vim.fn.chanclose(job_id, 'stdin')
    end

    return function()
      pcall(function() vim.fn.jobstop(job_id) end)
      handler:unsubscribe()
    end
  end)
end

return M
