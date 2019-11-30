local utils = require 'utils'
local nvim = require 'nvim'
local Funcref = require 'funcref'
local Subscription = require 'subscription'

local function create_executor(sink, sink_handles_all)
  local sub = Subscription:create()
  local sink_ref = nil

  if type(sink) == 'function' then
    sink_ref = Funcref:create(sink)
    sub = sink_ref.subscription
  end

  local function run(cmd)
    local conf_name = 'k' .. math.random(0, 1000000)

    nvim.g[conf_name] = cmd

    if sink_ref then
      nvim.command('let g:' .. conf_name .. '["sink' .. (sink_handles_all and '*' or '') .. '"] = ' .. sink_ref:getRefString())
    else
      nvim.command('let g:' .. conf_name .. '["sink"] = "' .. sink .. '"')
    end

    nvim.command('call fzf#run(fzf#wrap(g:' .. conf_name ..'))')
    nvim.command('unlet g:' .. conf_name)
  end

  return run, sink_ref, sub
end

return {
  create_executor = create_executor
}
