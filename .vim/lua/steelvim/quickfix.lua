local M = {}

function M.build_list(lines)
  vim.fn.setqflist(steel.fn.map(lines, function(line) return { filename = line } end))
  steel.ex.copen()
  steel.ex.cc()
end

function M.get_fzf_list()
  return steel.fzf.grid_to_source(
    steel.fzf.create_grid(
    {
      { heading = "Text"; length = 45; map = steel.ansi.red; };
      { heading = "Loc"; length = 12; map = steel.ansi.red; };
      { heading = "File"; map = steel.ansi.red; };
    }, 
    steel.fn.map(vim.fn.getqflist(), function(item, index)
      return {
        item.text,
        { value = item.lnum .. ":" .. item.col; map = steel.ansi.blue; },
        { value = vim.api.nvim_buf_get_name(item.bufnr); map = steel.ansi.cyan; },
        tostring(index)
      }
    end)
  ))
end

-- Filters the quick fix list using FZF
-- @param destructive Whether to overwrite the current quick fix list
function M.filter_qf(destructive)
  local fzf = steel.fzf:create(function(_, _, data)
    if not destructive then
      vim.fn.setqflist(data)
    else
      vim.fn.setqflist({}, 'r', { items = data })
    end
  end, { handle_all = true; indexed_data = true; })

  fzf:execute {
    source = M.get_fzf_list();
    window = steel.fzf.float_window(function() fzf:unsubscribe() end);
    options = { '--multi', '--nth=1..3', '--with-nth=1..3', '--ansi', '--header-lines=1' };
    data = vim.fn.getqflist();
  }
end

function M.delete_item(first_line, last_line)
  local qf_list = vim.fn.getqflist()
  local i = first_line

  while i <= last_line do
    table.remove(qf_list, first_line)
    i = i + 1
  end

  vim.fn.setqflist({}, 'r', { items = qf_list })
end

function M.add_line_to_quickfix(start_line, end_line)
  local list = vim.fn.getqflist()
  local buf = vim.api.nvim_win_get_buf(0)
  local lines = vim.api.nvim_buf_get_lines(buf, start_line, end_line, false)
  local qflist = steel.fn.map(lines, function(line, index)
    return {
      bufnr = buf,
      lnum = start_line + index - 1,
      col = 0,
      text = line
    }
  end)

  vim.fn.setqflist({ unpack(list), unpack(qflist) })
end

function M.new_qf_list(title)
  vim.fn.setqflist({}, ' ', { title = title or '' })
  steel.ex.copen()
end

return M
