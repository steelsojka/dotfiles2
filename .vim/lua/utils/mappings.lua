local utils = require 'utils/utils'
local nvim = require 'nvim'

LUA_MAPPINGS = {}
LUA_BUFFER_MAPPINGS = {}
LUA_AUGROUP_HOOKS = {}

local function escape_keymap(key)
	-- Prepend with a letter so it can be used as a dictionary key
	return 'k' .. key:gsub('.', string.byte)
end

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
  local bufnr = nvim.get_current_buf()

  if keys[1] == ' ' and mapping.which_key ~= false and mapping.description then
    if keys[2] == 'm' and is_buffer then
      local success, local_which_key_dict = pcall(function() return nvim.b.local_which_key end)

      if not success then
        local_which_key_dict = { m = {} }  
      end

      add_to_which_key({unpack(keys, 2)}, mapping.description, local_which_key_dict)

      nvim.b.local_which_key = local_which_key_dict
    elseif key_dict then
      add_to_which_key({unpack(keys, 2)}, mapping.description, key_dict)
    end
  end
  
  mapping[1] = nil
  mapping.description = nil
  mapping.which_key = nil
  mapping.buffer = nil 

  local escaped_key = escape_keymap(mode .. key_string)

  if type(action) == 'function' then
    if is_buffer then
      if not LUA_BUFFER_MAPPINGS[bufnr] then
        LUA_BUFFER_MAPPINGS[bufnr] = {}

        -- Clean up this map on detach
        nvim.buf_attach(bufnr, false, {
          on_detach = function()
            LUA_BUFFER_MAPPINGS[bufnr] = nil
          end
        })
      end

      LUA_BUFFER_MAPPINGS[bufnr][escaped_key] = action

      if (mode == 'v' or mode == 'x') then
        action = ([[:<C-u>lua LUA_BUFFER_MAPPINGS[%d]['%s']()<CR>]]):format(bufnr, escaped_key)
      else
        action = ([[<Cmd>lua LUA_BUFFER_MAPPINGS[%d]['%s']()<CR>]]):format(bufnr, escaped_key)
      end
    else
      LUA_MAPPINGS[escaped_key] = action

      if (mode == 'v' or mode == 'x') then
        action = ([[:<C-u>lua LUA_MAPPINGS['%s']()<CR>]]):format(escaped_key)
      else
        action = ([[<Cmd>lua LUA_MAPPINGS['%s']()<CR>]]):format(escaped_key)
      end
    end

    mapping.noremap = true
    mapping.silent = true
  end

  if is_buffer then
    nvim.buf_set_keymap(bufnr, mode, key_string, action, mapping)
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

local function create_augroups(definitions)
  for group_name,def in pairs(definitions) do
    nvim.ex['augroup LuaAugroup_' .. group_name]()
    nvim.ex.autocmd_()
    
    for index,def in pairs(def) do
      if type(def[#def]) == 'function' then
        fn = def[#def]
        def = {unpack(def, 1, #def - 1)}
        table.insert(def, ("lua LUA_AUGROUP_HOOKS['%s']()"):format(group_name .. index))
        LUA_AUGROUP_HOOKS[group_name .. index] = fn
      end

      local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')

      nvim.ex[command]()
    end

    nvim.ex['augroup END']()
  end
end

return {
  register_mapping = register_mapping,
  register_mappings = register_mappings,
  register_buffer_mappings = register_buffer_mappings,
  create_augroups = create_augroups,
  escape_keymap = escape_keymap
}
