local Fzf = {}

-- Creates an FZF executor for running FZF in lua
-- @param sink Function to execute with selected line(s)
-- @param handle_all Whether to handle all lines or call the sink for each line
function Fzf:create(sink, options)
  local instance = {}

  options = options or {}

  instance.subscription = steel.rx.subscription:create()
  instance.sink_ref = sink
  instance.fn_name = 'k' .. steel.utils.unique_id()
  instance.handle_all = options.handle_all
  instance.data = nil

  if type(sink) == 'function' then
    instance.sink_ref = steel.utils.funcref:create(function(ref, results)
      local data = instance.data

      if options.indexed_data then
        if not instance.data then
          error("No data provided to FZF")
        end

        if not vim.tbl_islist(results) then
          error("FZF results must be a list")
        end
        
        data = Fzf.extract_data_items(results, data)
        print(vim.inspect(data))
      end

      sink(ref, results, data)
      instance.data = nil
    end)

    instance.subscription:add(instance.sink_ref.subscription)
  end

  return setmetatable(instance, {
    __index = Fzf
  })
end

-- Executes with the given args
-- @param cmd Fzf args minus the sink
function Fzf:execute(cmd)
  vim.g[self.fn_name] = cmd

  if cmd.data then
    self.data = cmd.data
  end

  if type(self.sink_ref) ~= 'string' then
    steel.command(('let g:%s["sink%s"] = %s'):format(self.fn_name, self.handle_all and '*' or '', self.sink_ref:get_vim_ref_string()))
  else
    steel.command(('let g:%s["sink"] = "%s"'):format(self.fn_name, self.sink_ref))
  end

  steel.command(('call fzf#run(fzf#wrap(g:%s))'):format(self.fn_name))
  steel.command('unlet g:' .. self.fn_name)
end

-- Cleans up this fzf executor
function Fzf:unsubscribe()
  self.subscription:unsubscribe()
end

-- Creates a floating window for use with fzf
-- @param on_close An optional on close handler executed when the buffer is detached
function Fzf.create_floating_window(on_close)
  local buf = vim.api.nvim_create_buf(false, true)
  local columns = vim.o.columns
  local lines = vim.o.lines
  local width = math.floor(columns - (columns * 2 / 20)) local height = lines - 3
  local y = height
  local x = math.floor((columns - width) / 2)

  if on_close then
    vim.api.nvim_buf_attach(buf, false, {
      on_detach = vim.schedule_wrap(on_close)
    })
  end

  vim.fn.setbufvar(buf, '&signcolumn', 'no' )
  vim.api.nvim_open_win(buf, true, { relative = 'editor', row = y, col = x, width = width, height = height })
  steel.ex.setlocal 'winblend=10'
end

-- Gets the execution string used in FZF config options
-- @param on_close Optional handler to call on buffer detachment
function Fzf.float_window(on_close)
  if on_close then
    local fn_ref = steel.utils.funcref:create(function(ref)
      on_close()
      ref:unsubscribe()
    end)

    return ("lua steel.fzf.create_floating_window(%s)"):format(fn_ref:get_lua_ref_string())
  end

  return [[lua steel.fzf.create_floating_window()]]
end

-- Creates a grid with a header row and columns that
-- are lined up vertically.
function Fzf.create_grid(headings, items)
  local new_items = {}
  local header_row = {}

  for index,item in ipairs(headings) do
    local heading = item.heading
    local result = heading

    if type(item.map) == "function" then
      result = item.map(result)
    end

    if item.length then
      local diff = item.length - #heading

      result = result .. string.rep(" ", diff)
    end

    table.insert(header_row, result)
  end

  table.insert(new_items, header_row)

  for _,item_parts in ipairs(items) do
    local new_item = {}

    for i,item_part in ipairs(item_parts) do
      local heading = headings[i]
      local is_tbl = type(item_part) == "table"
      local value = is_tbl and item_part.value or item_part
      local res = value

      if is_tbl and type(item_part.map) == "function" then
        res = item_part.map(res)
      end

      if heading and heading.length and #value < heading.length then
        local diff = heading.length - #value

        res = res .. string.rep(" ", diff)
      end

      table.insert(new_item, res)
    end

    table.insert(new_items, new_item)
  end

  return new_items
end

function Fzf.grid_to_source(grid)
  return steel.fn.map(grid, function(row) 
    return table.concat(row, " ")
  end)
end

function Fzf.extract_data_items(results, data)
  return steel.fn.reduce(results, function(res, result)
    local index = tonumber(string.char(string.byte(result, -1)))

    if data[index] then
      table.insert(res, data[index])
    end

    return res
  end, {})
end

return Fzf
