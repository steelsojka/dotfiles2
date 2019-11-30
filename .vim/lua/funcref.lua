local nvim = require 'nvim'
local Subscription = require 'subscription'
local Funcref = {}

LUA_FUNCTION_REFS = {}

nvim.command [[
  function! LuaFunctionRefHandler(name, ...)
    return luaeval("LUA_FUNCTION_REFS[_A.name](unpack(_A.args))", {'name': a:name, 'args': a:000})
  endfunction
]]

function Funcref:create(fn)
  local instance = {}

  instance.name = 'k' .. math.random(1, 1000000)
  instance.subscription = Subscription:create(function()
    LUA_FUNCTION_REFS[instance.name] = nil
  end)

  LUA_FUNCTION_REFS[instance.name] = function(...)
    fn(instance, ...)
  end

  return setmetatable(instance, {
    __index = Funcref
  })
end

function Funcref:unsubscribe()
  self.subscription:unsubscribe()
end

function Funcref:getRefString()
  return 'function("LuaFunctionRefHandler", ["' .. self.name .. '"])'
end

return Funcref
