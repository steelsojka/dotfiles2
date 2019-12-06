local nvim = require 'nvim'
local utils = require 'utils/utils'
local Fzf = require 'fzf/fzf'

local function build_list(lines)
  nvim.fn.setqflist(utils.map(lines, function(line) return { filename = line } end))
  nvim.ex.copen()
  nvim.ex.cc()
end

local function get_fzf_list()
  local qf_list = nvim.fn.getqflist()

  return utils.map(
    qf_list, 
    function(item, i)
      return ('%d\t%s\t%d:%d\t%s'):format(i, nvim.buf_get_name(item.bufnr), item.lnum, item.col, item.text)
    end
  ) 
end

-- Filters the quick fix list using FZF
-- @param destructive Whether to overwrite the current quick fix list
local function filter_qf(destructive)
  local fzf = Fzf:create(function(ref, lines)
    local qf_list = nvim.fn.getqflist()
    local rows_to_keep = utils.filter(
      utils.map(lines, function(line) return line:match('^([0-9]+)') end),
      function(line) return line ~= nil end
    )
    local new_results = utils.filter(qf_list, function(item, i) return vim.tbl_contains(rows_to_keep, tostring(i)) end)

    if not destructive then
      nvim.fn.setqflist(new_results)
    else
      nvim.fn.setqflist({}, 'r', { items = new_results })
    end
  end, true)

  fzf:execute {
    source = get_fzf_list(),
    window = Fzf.float_window(function() fzf:unsubscribe() end),
    options = { '--multi', '--nth=2..', '--with-nth=2..' }
  } 
end

local function delete_item(first_line, last_line)
  local qf_list = nvim.fn.getqflist()
  local i = first_line
  
  while i <= last_line do
    table.remove(qf_list, first_line)
    i = i + 1
  end

  nvim.fn.setqflist({}, 'r', { items = qf_list })
end


return {
  build_list = build_list,
  filter = filter_qf,
  delete_item = delete_item
}
