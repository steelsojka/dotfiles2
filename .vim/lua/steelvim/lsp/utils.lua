local M = {}

function M.file_to_location(filepath, lnum, col)
  return {
    uri = vim.uri_from_fname(filepath);
    range = {
      start = {
        line = lnum;
        character = col;
      };
    };
  } 
end

return M
