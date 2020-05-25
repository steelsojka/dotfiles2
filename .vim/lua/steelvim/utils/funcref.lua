local Funcref = {}
local NOOP = function() end

__LUA_FUNCTION_REFS = setmetatable({}, {
  __index = function(tbl, key)
    local handler = rawget(tbl, key)

    return handler == nil and NOOP or handler
  end
})

steel.command [[
  function! LuaFunctionRefHandler(name, ...)
    return luaeval("__LUA_FUNCTION_REFS[_A.name](unpack(_A.args))", {'name': a:name, 'args': a:000})
  endfunction
]]

-- Creates a function that can be easily accessed in VimL.
-- This is primarily for creating function refs in Lua.
-- @param fn The function code to execute
function Funcref:create(fn, opts)
  local instance = {}
  local _opts = opts or {}

  instance.name = (_opts.name or 'k') .. steel.utils.unique_id()
  instance.subscription = steel.rx.subscription:create(function()
    __LUA_FUNCTION_REFS[instance.name] = nil
  end)

  __LUA_FUNCTION_REFS[instance.name] = function(...) fn(instance, ...) end

  return setmetatable(instance, {
    __index = Funcref
  })
end

-- Unsubcribes the function ref
function Funcref:unsubscribe()
  self.subscription:unsubscribe()
end

-- Gets a string in VimL that creates a function ref to this Lua function.
function Funcref:get_vim_ref_string(...)
  return ('function("LuaFunctionRefHandler", [%s])'):format(steel.fn.join({ '"' .. self.name .. '"', ... }, ','))
end

-- Gets a string to reference this function from Lua.
function Funcref:get_lua_ref_string()
  return ('__LUA_FUNCTION_REFS["%s"]'):format(self.name)
end

return Funcref
