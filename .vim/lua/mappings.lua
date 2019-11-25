local utils = require 'utils'
local nvim = require 'nvim'

LUA_MAPPINGS = {}

local function parse_key_map(key_str)
  local result = {} 
  local i = 1
  local len = key_str:len()
  local is_meta = false
  local char_result = ''
  local key_index = 1

  while i <= len do
    local char = key_str:sub(i, i)

    if not is_meta and char == '<' then
      is_meta = true
      char_result = '<'
    elseif is_meta and char == '>' then
      is_meta = false
      result[key_index] = char_result .. '>'
      key_index = key_index + 1
      char_result = ''
    elseif is_meta then
      char_result = char_result .. char
    else
      result[key_index] = char
      key_index = key_index + 1
      char_result = ''
    end

    i = i + 1
  end

  return result
end

local function add_to_which_key(keys, description, key_dict)
  local category = key_dict
  local category_keys = {unpack(keys, 1, #keys - 1)}
  local end_key = keys[#keys]

  for i,key in ipairs(category_keys) do
    category = category[key]
  end

  category[end_key] = description
end

local function register_mapping(key, mapping, key_dict)
  local mode, key_string = key:match("^(.)(.+)$")
  local keys = parse_key_map(key_string)
  local action = mapping[1]
  local is_buffer = mapping.buffer

  if keys[1] == ' ' and mapping.which_key ~= false and mapping.description then
    if keys[2] == 'm' and is_buffer then
      local success, local_which_key_dict = pcall(function() return nvim.b.local_which_key end)

      if not success then
        local_which_key_dict = { m = {} }  
      end

      local t = pcall(function() add_to_which_key({unpack(keys, 2)}, mapping.description, local_which_key_dict) end)

      if not t then
        print(unpack(keys))
      end

      nvim.b.local_which_key = local_which_key_dict
    elseif key_dict then
      add_to_which_key({unpack(keys, 2)}, mapping.description, key_dict)
    end
  end
  
  mapping[1] = nil
  mapping.description = nil
  mapping.which_key = nil
  mapping.buffer = nil 

  if type(action) == 'function' then
    LUA_MAPPINGS[mode .. key_string] = action

    if (mode == 'v') then
      action = ([[:<C-u>lua LUA_MAPPINGS['%s']()<CR>]]):format(mode .. key_string)
    else
      action = ([[<Cmd>lua LUA_MAPPINGS['%s']()<CR>]]):format(mode .. key_string)
    end
  end

  if is_buffer then
    local buf = nvim.get_current_buf()

    nvim.buf_set_keymap(buf, mode, key_string, action, mapping)
  else
    nvim.set_keymap(mode, key_string, action, mapping)
  end
end

local function register_mappings(mappings, default_options, which_key_dict)
  for keys, mapping in pairs(mappings) do
    register_mapping(keys, vim.tbl_extend('keep', mapping, default_options or {}), which_key_dict)
  end
end

local function register_buffer_mappings(mappings, default_options)
  for keys, mapping in pairs(mappings) do
    register_mapping(keys, vim.tbl_extend('keep', { buffer = true }, mapping, default_options or {}))
  end
end

return {
  register_mapping = register_mapping,
  register_mappings = register_mappings,
  register_buffer_mappings = register_buffer_mappings
}
