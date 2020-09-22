local M = {}

function M.fzf_files(query, fullscreen, history_filename)
  local local_folder = steel.project.create_project_local(vim.fn.expand('%:p:h'))
  local spec = {
    options = {
      '--history', local_folder .. '/' .. (history_filename or 'fzf-history-files')
    };
  }

  if fullscreen == 1 then
    vim.fn['fzf#vim#files'](query, vim.fn['fzf#vim#with_preview'](spec, 'up:80%'), 1)
  else
    vim.fn['fzf#vim#files'](query, vim.fn['fzf#vim#with_preview'](spec), 0)
  end
end

-- Searches for a file in the project and inserts the relative
-- path from the path provided.
-- Requires node to be installed (which it will always be... let's be real).
-- @param from_path The path for the file to be relative from.
function M.insert_relative_path(from_path)
  local fzf_instance = steel.fzf:create(function(ref, other_path)
    local cwd = vim.fn.getcwd()

    if cwd then
      local lines = steel.fs.exec(
        string.format([[node -p "require('path').relative('%s', '%s/%s')"]], from_path, cwd, other_path)
      )
      local result = lines[1]

      if result then
        -- Paths that don't move up need a './' in front.
        if result:sub(1, 1) ~= '.' then
          result = './' .. result
        end

        -- Enter insert mode and type the text.
        steel.command("normal! i" .. result)
        -- Move back to position and enter insert mode.
        vim.api.nvim_input 'li'
      else
        print "No path result!"
      end
    else
      print "No working directory!"
    end

    ref:unsubscribe()
  end)

  fzf_instance:execute {
    source = [[rg --files]],
    window = steel.fzf.float_window()
  }
  -- Escape mode and enter insert mode.
  vim.api.nvim_input '<esc>i'
end

return M
