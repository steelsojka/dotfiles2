local utils = require 'utils'
local nvim = require 'nvim'

local function create_executor(sink, sink_handles_all)
  local sink_ref = type(sink) == 'function' and utils.create_function_ref(sink) or nil

  local function run(cmd)
    local conf_name = 'k' .. math.random(0, 1000000)

    nvim.g[conf_name] = cmd

    if sink_ref then
      nvim.command('let g:' .. conf_name .. '["sink' .. (sink_handles_all and '*' or '') .. '"] = function("' .. sink_ref .. '")')
    else
      nvim.command('let g:' .. conf_name .. '["sink"] = "' .. sink .. '"')
    end

    nvim.command('call fzf#run(fzf#wrap(g:' .. conf_name ..'))')
    nvim.command('unlet g:' .. conf_name)
  end

  return run, sink_ref
end

return {
  create_executor = create_executor
}
