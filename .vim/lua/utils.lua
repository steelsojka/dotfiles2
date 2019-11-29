local nvim = require 'nvim'

LUA_FUNCTION_REFS = {}

local function reduce(list, accumulator, start_value)
  local result = start_value

  for i,value in ipairs(list) do
    result = accumulator(result, value, i)
  end

  return result
end

local function map(list, mapper)
  return reduce(list, function(res, item, i)
    table.insert(res, mapper(item, i))

    return res
  end, {})
end

local function filter(list, predicate)
  return reduce(list, function(res, item, i)
    if predicate(item, i) then
      table.insert(res, item)
    end

    return res
  end, {})
end

local function join(list, delimiter) 
  return reduce(list, function(res, item)
    return res == '' and tostring(item) or (res .. delimiter .. tostring(item))
  end, '')
end 

local function create_function_ref(fn)
  local name = 'K' .. math.random(1, 1000000)
  local fn_def = {
    'function! ' .. name .. '(...)',
    ([[  return luaeval("LUA_FUNCTION_REFS['%s'](unpack(_A))", a:000)]]):format(name),
    'endfunction'
  }

  LUA_FUNCTION_REFS[name] = fn
  nvim.command(join(fn_def, '\n'))

  return name 
end

return {
  reduce = reduce,
  map = map,
  filter = filter,
  join = join,
  create_function_ref = create_function_ref
}
