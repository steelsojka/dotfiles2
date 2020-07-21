local M = {}

M._fzf_location_handler = steel.fzf:create(function(_, _, data)
  steel.lsp.handle_location_items(data, function(item)
    return steel.lsp.file_to_location(item.filename, item.lnum - 1, item.col - 1)
  end)
end, { handle_all = true; indexed_data = true; })

M._fzf_code_action_handler = steel.fzf:create(function(_, _, actions)
  for _,action in ipairs(actions) do
    if action.edit or type(action.command) == 'table' then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end

      if type(action.command) == 'table' then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end
end, { handle_all = true; indexed_data = true; })

function M.location_callback(_, _, result, _, _)
  if not result or vim.tbl_isempty(result) then return end

  if vim.tbl_islist(result) then
    if #result > 1 then
      local items = vim.lsp.util.locations_to_items(result)
      local grid = steel.fzf.create_grid(
        {
          { heading = "Text"; length = 60; map = steel.ansi.red; truncate = true; },
          { heading = "Loc"; length = 12; map = steel.ansi.red; },
          { heading = "File"; map = steel.ansi.red; }
        },
        steel.fn.map(items, function(item, index)
          return {
            vim.trim(item.text),
            { value = item.lnum .. ":" .. item.col; map = steel.ansi.blue; },
            { value = item.filename; map = steel.ansi.cyan; },
            tostring(index)
          }
          end
        )
      )

      M._fzf_location_handler:execute {
        options = { "--multi", "--ansi", "--header-lines=1" };
        source = steel.fzf.grid_to_source(grid);
        window = steel.fzf.float_window();
        data = items;
      }
    else
      vim.lsp.util.jump_to_location(result[1])
    end
  else
    vim.lsp.util.jump_to_location(result)
  end
end

function M.symbol_callback(_, _, result, _, _)
  if not result or vim.tbl_isempty(result) then return end

  local items = vim.lsp.util.symbols_to_items(result)
  local grid = steel.fzf.create_grid(
    {
      { heading = "Symbol"; length = 35; map = steel.ansi.red; truncate = true; },
      { heading = "Loc"; length = 12; map = steel.ansi.red; },
      { heading = "Kind"; length = 15; map = steel.ansi.red; },
      { heading = "File"; map = steel.ansi.red; }
    },
    steel.fn.map(items, function(item, index)
      local symbol = item.text:match("] (.*)")

      return {
        symbol,
        { value = item.lnum .. ":" .. item.col; map = steel.ansi.blue; },
        { value = item.kind; map = steel.ansi.yellow; },
        { value = item.filename; map = steel.ansi.cyan; },
        tostring(index)
      }
      end
    )
  )

  M._fzf_location_handler:execute {
    options = { "--multi", "--ansi", "--with-nth=1..4", "-n", "1,3,4", "--header-lines=1" };
    source = steel.fzf.grid_to_source(grid);
    window = steel.fzf.float_window();
    data = items;
  }
end

function M.code_action_callback(_, _, actions, _, _)
  if not actions or vim.tbl_isempty(actions) then
    print("No code actions available")
    return
  end

  local grid = steel.fzf.create_grid(
    {
      { heading = "Title"; map = steel.ansi.red; }
    },
    steel.fn.map(actions, function(action, index)
      return { action.title, tostring(index) }
    end)
  )

  M._fzf_code_action_handler:execute {
    options = { "--ansi", "--header-lines=1" };
    source = steel.fzf.grid_to_source(grid);
    window = steel.fzf.float_window();
    data = actions;
  }
end

return M
