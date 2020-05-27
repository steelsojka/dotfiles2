local lsp_utils = require 'steelvim/lsp/utils'

local M = {}

M._fzf_symbol_handler = steel.fzf:create(function(_, _, data)
  if #data > 1 then
    local locations = steel.fn.map(data, function(item)
      return lsp_utils.file_to_location(item.filename, item.lnum - 1, item.col - 1)
    end)

    local items = vim.lsp.util.locations_to_items(locations)

    vim.lsp.util.set_qflist(items)
    steel.ex.copen()
  else
    vim.lsp.util.jump_to_location(lsp_utils.file_to_location(data[1].filename, data[1].lnum - 1, data[1].col - 1))
  end
end, { handle_all = true, indexed_data = true })

function M.symbol_callback(_, _, result, _, bufnr)
  if not result or vim.tbl_isempty(result) then return end

  local items = vim.lsp.util.symbols_to_items(result)
  local grid = steel.fzf.create_grid(
    {
      { heading = "Symbol"; length = 35; map = steel.ansi.red; },
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

  M._fzf_symbol_handler:execute {
    options = { "--multi", "--ansi", "--with-nth=1..4", "-n", "1,3,4", "--header-lines=1" };
    source = steel.fzf.grid_to_source(grid);
    window = steel.fzf.float_window();
    data = items;
  }
end

return M
