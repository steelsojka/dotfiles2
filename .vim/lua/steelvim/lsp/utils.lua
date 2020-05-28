local M = {}

function M.file_to_location(filepath, lnum, col)
  return M.uri_to_location(vim.uri_from_fname(filepath), lnum, col)
end

function M.uri_to_location(uri, lnum, col)
  return {
    uri = uri;
    range = {
      start = {
        line = lnum;
        character = col;
      };
    };
  } 
end

function M.handle_location_items(data, location_creator)
  if #data > 1 then
    local locations = steel.fn.map(data, function(item)
      return location_creator(item)
    end)

    print(vim.inspect(locations))

    local items = vim.lsp.util.locations_to_items(locations)

    vim.lsp.util.set_qflist(items)
    steel.ex.copen()
  elseif #data == 1 then
    vim.lsp.util.jump_to_location(location_creator(data[1]))
  end
end

return M
