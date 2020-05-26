local M = {}

function M.reduce(list, accumulator, start_value)
  local result = start_value

  for i,value in ipairs(list) do
    result = accumulator(result, value, i)
  end

  return result
end

function M.map(list, mapper)
  return M.reduce(list, function(res, item, i)
    table.insert(res, mapper(item, i))

    return res
  end, {})
end

function M.filter(list, predicate)
  return M.reduce(list, function(res, item, i)
    if predicate(item, i) then
      table.insert(res, item)
    end

    return res
  end, {})
end

function M.find(list, predicate)
  for i,v in ipairs(list) do
    if predicate(v,i) then
      return v, i
    end
  end
end

function M.join(list, delimiter)
  return M.reduce(list, function(res, item)
    return res == '' and tostring(item) or (res .. delimiter .. tostring(item))
  end, '')
end

function M.split(str, split_on)
  local result = {}

  for i in string.gmatch(str .. split_on, "([^" .. split_on .. "]+)" .. split_on) do
    table.insert(result, i)
  end

  return result
end

function M.concat(list1, list2)
  return M.reduce(list2, function(res, item)
    table.insert(res, item)

    return res
  end, { unpack(list1) })
end

function M.indexOf(list, value)
  for i,v in ipairs(list) do
    if v == value then return i end
  end

  return nil
end

return M 
