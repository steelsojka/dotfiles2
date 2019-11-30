local nvim = require 'nvim'

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

return {
  reduce = reduce,
  map = map,
  filter = filter,
  join = join
}
