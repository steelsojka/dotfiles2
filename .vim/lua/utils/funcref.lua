local nvim = require 'nvim'
local Subscription = require 'utils/subscription'
local unique_id = require 'utils/unique_id'

local Funcref = {}

LUA_FUNCTION_REFS = {}

nvim.command [[
  function! LuaFunctionRefHandler(name, ...)
    return luaeval("LUA_FUNCTION_REFS[_A.name](unpack(_A.args))", {'name': a:name, 'args': a:000})
  endfunction
]]

-- Creates a function that can be easily accessed in VimL.
-- This is primarily for creating function refs in Lua.
-- @param fn The function code to execute
function Funcref:create(fn, opts)
  local instance = {}
  local _opts = opts or {}

  instance.name = _opts.name or 'k' .. unique_id()
  instance.subscription = Subscription:create(function()
    LUA_FUNCTION_REFS[instance.name] = nil
  end)

  LUA_FUNCTION_REFS[instance.name] = function(...) fn(instance, ...) end

  return setmetatable(instance, {
    __index = Funcref
  })
end

-- Unsubcribes the function ref
function Funcref:unsubscribe()
  self.subscription:unsubscribe()
end

-- Gets a string in VimL that creates a function ref to this Lua function.
function Funcref:get_vim_ref_string()
  return ('function("LuaFunctionRefHandler", ["%s"])'):format(self.name)
end

-- Gets a string to reference this function from Lua.
function Funcref:get_lua_ref_string()
  return ('LUA_FUNCTION_REFS["%s"]'):format(self.name)
end

return Funcref
