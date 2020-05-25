local M = {}

function M.build_list(lines)
  vim.fn.setqflist(steel.fn.map(lines, function(line) return { filename = line } end))
  steel.ex.copen()
  steel.ex.cc()
end

function M.get_fzf_list()
  local qf_list = vim.fn.getqflist()

  return steel.fn.map(
    qf_list,
    function(item, i)
      return ('%d\t%s\t%d:%d\t%s'):format(i, vim.api.nvim_buf_get_name(item.bufnr), item.lnum, item.col, item.text)
    end
  )
end

-- Filters the quick fix list using FZF
-- @param destructive Whether to overwrite the current quick fix list
function M.filter_qf(destructive)
  local fzf = steel.fzf:create(function(_, lines)
    local qf_list = vim.fn.getqflist()
    local rows_to_keep = steel.fn.filter(
      steel.fn.map(lines, function(line) return line:match('^([0-9]+)') end),
      function(line) return line ~= nil end
    )
    local new_results = steel.fn.filter(qf_list, function(_, i) return vim.tbl_contains(rows_to_keep, tostring(i)) end)

    if not destructive then
      vim.fn.setqflist(new_results)
    else
      vim.fn.setqflist({}, 'r', { items = new_results })
    end
  end, true)

  fzf:execute {
    source = M.get_fzf_list(),
    window = steel.fzf.float_window(function() fzf:unsubscribe() end),
    options = { '--multi', '--nth=1..', '--with-nth=2..' }
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
