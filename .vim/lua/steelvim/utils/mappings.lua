local nvim = require 'nvim'

local M = {}

M._LUA_MAPPINGS = {}
M._LUA_BUFFER_MAPPINGS = {}
M._LUA_AUGROUP_HOOKS = {}

local require_string = [[require('steelvim/utils/mappings')]]

function M.unimplemented()
  print('Unimplemented mapping!');
end

function M.escape_keymap(key)
	-- Prepend with a letter so it can be used as a dictionary key
	return 'k' .. key:gsub('.', string.byte)
end

function M.init_buffer_mappings(initial_mappings)
  local success, local_which_key_dict = pcall(function() return nvim.b.local_which_key end)

  if not success or type(local_which_key_dict) ~= 'table' then
    local_which_key_dict = { m = initial_mappings or {} }
  end

  nvim.b.local_which_key = local_which_key_dict

  return local_which_key_dict
end

function M.parse_key_map(key_str)
  local result = {}
  local i = 1
  local len = #key_str
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

function M.add_to_which_key(keys, description, key_dict)
  local category = key_dict
  local category_keys = {unpack(keys, 1, #keys - 1)}
  local end_key = keys[#keys]

  for _,key in ipairs(category_keys) do
    category = category[key]
  end

  category[end_key] = description
end

function M.register_mapping(key, mapping, key_dict)
  local mode, key_string = key:match("^(.)(.+)$")
  local keys = M.parse_key_map(key_string)
  local action = mapping[1]
  local is_buffer = mapping.buffer == true or type(mapping.buffer) == 'number'
  local bufnr = type(mapping.buffer) == 'number' and mapping.buffer or nvim.get_current_buf()

  if keys[1] == ' ' and mapping.which_key ~= false and mapping.description then
    if keys[2] == 'm' and is_buffer then
      local local_which_key_dict = M.init_buffer_mappings()

      M.add_to_which_key({unpack(keys, 2)}, mapping.description, local_which_key_dict)

      nvim.b.local_which_key = local_which_key_dict
    elseif key_dict then
      M.add_to_which_key({unpack(keys, 2)}, mapping.description, key_dict)
    end
  end

  mapping[1] = nil
  mapping.description = nil
  mapping.which_key = nil
  mapping.buffer = nil

  local escaped_key = M.escape_keymap(mode .. key_string)

  if type(action) == 'function' then
    if is_buffer then
      if not M._LUA_BUFFER_MAPPINGS[bufnr] then
        M._LUA_BUFFER_MAPPINGS[bufnr] = {}

        -- Clean up this map on detach
        nvim.buf_attach(bufnr, false, {
          on_detach = function()
            M._LUA_BUFFER_MAPPINGS[bufnr] = nil
          end
        })
      end

      M._LUA_BUFFER_MAPPINGS[bufnr][escaped_key] = action

      if (mode == 'v' or mode == 'x') then
        action = ([[:<C-u>lua %s._LUA_BUFFER_MAPPINGS[%d]['%s']()<CR>]]):format(require_string, bufnr, escaped_key)
      else
        action = ([[<Cmd>lua %s._LUA_BUFFER_MAPPINGS[%d]['%s']()<CR>]]):format(require_string, bufnr, escaped_key)
      end
    else
      M._LUA_MAPPINGS[escaped_key] = action

      if (mode == 'v' or mode == 'x') then
        action = ([[:<C-u>lua %s._LUA_MAPPINGS['%s']()<CR>]]):format(require_string, escaped_key)
      else
        action = ([[<Cmd>lua %s._LUA_MAPPINGS['%s']()<CR>]]):format(require_string, escaped_key)
      end
    end

    mapping.noremap = true
    mapping.silent = true
  elseif type(action) == 'string' then
    -- Plug mappings always have noremap set to false
    if action:lower():match('^<plug>') then
      mapping.noremap = false
    end
  end

  if is_buffer then
    nvim.buf_set_keymap(bufnr, mode, key_string, action, mapping)
  else
    nvim.set_keymap(mode, key_string, action, mapping)
  end
end

function M.register_mappings(mappings, default_options, which_key_dict)
  for keys, mapping in pairs(mappings) do
    M.register_mapping(keys, vim.tbl_extend('keep', mapping, default_options or {}), which_key_dict)
  end
end

function M.register_buffer_mappings(mappings, default_options, buffer)
  for keys, mapping in pairs(mappings) do
    M.register_mapping(keys, vim.tbl_extend('keep', { buffer = buffer or true }, mapping, default_options or {}))
  end
end

function M.create_augroups(definitions)
  for group_name,defs in pairs(definitions) do
    nvim.ex['augroup LuaAugroup_' .. group_name]()
    nvim.ex.autocmd_()

    for index,def in pairs(defs) do
      if type(def[#def]) == 'function' then
        local fn = def[#def]

        def = {unpack(def, 1, #def - 1)}
        table.insert(def, ("lua %s._LUA_AUGROUP_HOOKS['%s']()"):format(require_string, group_name .. index))
        M._LUA_AUGROUP_HOOKS[group_name .. index] = fn
      end

      local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')

      nvim.ex[command]()
    end

    nvim.ex['augroup END']()
  end
end

return M
