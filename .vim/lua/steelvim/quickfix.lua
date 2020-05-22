local nvim = require 'nvim'
local utils = require 'steelvim/utils/utils'
local Fzf = require 'steelvim/fzf/fzf'

local M = {}

function M.build_list(lines)
  vim.fn.setqflist(utils.map(lines, function(line) return { filename = line } end))
  nvim.ex.copen()
  nvim.ex.cc()
end

function M.get_fzf_list()
  local qf_list = vim.fn.getqflist()

  return utils.map(
    qf_list,
    function(item, i)
      return ('%d\t%s\t%d:%d\t%s'):format(i, nvim.buf_get_name(item.bufnr), item.lnum, item.col, item.text)
    end
  )
end

-- Filters the quick fix list using FZF
-- @param destructive Whether to overwrite the current quick fix list
function M.filter_qf(destructive)
  local fzf = Fzf:create(function(_, lines)
    local qf_list = vim.fn.getqflist()
    local rows_to_keep = utils.filter(
      utils.map(lines, function(line) return line:match('^([0-9]+)') end),
      function(line) return line ~= nil end
    )
    local new_results = utils.filter(qf_list, function(_, i) return vim.tbl_contains(rows_to_keep, tostring(i)) end)

    if not destructive then
      vim.fn.setqflist(new_results)
    else
      vim.fn.setqflist({}, 'r', { items = new_results })
    end
  end, true)

  fzf:execute {
    source = M.get_fzf_list(),
    window = Fzf.float_window(function() fzf:unsubscribe() end),
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
  local buf = nvim.win_get_buf(0)
  local lines = nvim.buf_get_lines(buf, start_line, end_line, false)
  local qflist = utils.map(lines, function(line, index)
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
  nvim.ex.copen()
end

return M
