local M = {}

M._fzf_references_handler = steel.fzf:create(function(_, _, data)
  steel.lsp.handle_location_items(data, function(item)
    return steel.lsp.file_to_location(item.filename, item.lnum - 1, item.col - 1)
  end)
end, { handle_all = true; indexed_data = true; })

function M.references_fzf_callback(_, _, result, _, _)
  if not result or vim.tbl_isempty(result) then return end

  local items = vim.lsp.util.locations_to_items(result)
  local grid = steel.fzf.create_grid(
    {
      { heading = "Text"; length = 60; map = steel.ansi.red; truncate = true; },
      { heading = "Loc"; length = 12; map = steel.ansi.red; },
      { heading = "File"; map = steel.ansi.red; }
    }, 
    steel.fn.map(items, function(item, index)
      return {
        item.text,
        { value = item.lnum .. ":" .. item.col; map = steel.ansi.blue; },
        { value = item.filename; map = steel.ansi.cyan; },
        tostring(index)
      }
      end
    )
  )

  M._fzf_references_handler:execute {
    options = { "--multi", "--ansi", "--header-lines=1" };
    source = steel.fzf.grid_to_source(grid);
    window = steel.fzf.float_window();
    data = items;
  }
end

return M
