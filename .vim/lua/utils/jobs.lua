local Observable = require 'utils/observable'
local Funcref = require 'utils/funcref'
local nvim = require 'nvim'

local function is_eof(list)
  return type(list) == 'table' and list[1] == "" and list[2] == nil
end

local function job_start(cmd)
  return Observable:create(function(subscriber)
    local result = {}
    local handler = Funcref:create(function(ref, jobid, data, event)
      if event == 'stdout' then
        if is_eof(data) then
          subscriber.next(result)
        else 
          for __,v in pairs(data) do
            table.insert(result, v)
          end
        end
      elseif event == 'stderr' and not is_eof(data) then
        subscriber.error(data)
      elseif event == 'exit' then
        subscriber.complete()
      end
    end)

    nvim.command(([[
      call jobstart('%s', { 'on_stdout': %s, 'on_stderr': %s, 'on_exit': %s })
    ]]):format(
      cmd,
      handler:get_vim_ref_string(),
      handler:get_vim_ref_string(),
      handler:get_vim_ref_string()
    ))

    return function()
      handler:unsubscribe()
    end
  end) 
end

return {
  job_start = job_start
}
