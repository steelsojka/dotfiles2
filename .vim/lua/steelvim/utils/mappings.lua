local M = {}

M._LUA_MAPPINGS = {}
M._LUA_BUFFER_MAPPINGS = {}
M._LUA_AUGROUP_HOOKS = {}

function M.unimplemented()
  print('Unimplemented mapping!');
end

function M.escape_keymap(key)
	-- Prepend with a letter so it can be used as a dictionary key
	return 'k' .. key:gsub('.', string.byte)
end

function M.init_buffer_mappings(initial_mappings)
  local success, local_which_key_dict = pcall(function() return vim.b.local_which_key end)

  if not success or type(local_which_key_dict) ~= 'table' then
    local_which_key_dict = { m = initial_mappings or {} }
  end

  vim.b.local_which_key = local_which_key_dict

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
  local bufnr = type(mapping.buffer) == 'number' and mapping.buffer or vim.api.nvim_get_current_buf()

  if keys[1] == ' ' and mapping.which_key ~= false and mapping.description then
    if keys[2] == 'm' and is_buffer then
      local local_which_key_dict = M.init_buffer_mappings()

      M.add_to_which_key({unpack(keys, 2)}, mapping.description, local_which_key_dict)

      vim.b.local_which_key = local_which_key_dict
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
        vim.api.nvim_buf_attach(bufnr, false, {
          on_detach = function()
            M._LUA_BUFFER_MAPPINGS[bufnr] = nil
          end
        })
      end

      M._LUA_BUFFER_MAPPINGS[bufnr][escaped_key] = action

      if (mode == 'v' or mode == 'x') then
        action = ([[:<C-u>lua steel.mappings._LUA_BUFFER_MAPPINGS[%d]['%s']()<CR>]]):format(bufnr, escaped_key)
      else
        action = ([[<Cmd>lua steel.mappings._LUA_BUFFER_MAPPINGS[%d]['%s']()<CR>]]):format(bufnr, escaped_key)
      end
    else
      M._LUA_MAPPINGS[escaped_key] = action

      if (mode == 'v' or mode == 'x') then
        action = ([[:<C-u>lua steel.mappings._LUA_MAPPINGS['%s']()<CR>]]):format(escaped_key)
      else
        action = ([[<Cmd>lua steel.mappings._LUA_MAPPINGS['%s']()<CR>]]):format(escaped_key)
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
    vim.api.nvim_buf_set_keymap(bufnr, mode, key_string, action, mapping)
  else
    vim.api.nvim_set_keymap(mode, key_string, action, mapping)
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

function M.create_autocmd(def, name)
  name = name or ('Lua_autocmd_' .. steel.utils.unique_id())

  if type(def[#def]) == 'function' then
    local fn = def[#def]

    def = {unpack(def, 1, #def - 1)}
    table.insert(def, ("lua steel.mappings._LUA_AUGROUP_HOOKS['%s']()"):format(name))
    M._LUA_AUGROUP_HOOKS[name] = fn
  end

  local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')

  steel.command(command)
end

function M.create_autocmds(defs)
  for _,def in ipairs(defs) do
    M.create_autocmd(def)
  end
end

function M.create_augroups(definitions)
  if vim.tbl_islist(definitions) then
    
  else
    for group_name,defs in pairs(definitions) do
      steel.command('augroup LuaAugroup_' .. group_name)
      steel.command('autocmd!')

      for index,def in ipairs(defs) do
        M.create_autocmd(def, group_name .. index)
      end

      steel.command('augroup END')
    end
  end
end

return M
