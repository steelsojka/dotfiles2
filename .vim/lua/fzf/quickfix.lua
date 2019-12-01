-- Fzf features for the quick fix list

local nvim = require 'nvim'
local Fzf = require 'fzf/fzf'
local utils = require 'utils'

local function get_list()
  local qf_list = nvim.fn.getqflist()

  return utils.map(
    qf_list, 
    function(item, i)
      return i .. '|' .. nvim.buf_get_name(item.bufnr) .. '|' .. item.lnum .. ':' .. item.col .. '| ' .. item.text
    end
  ) 
end

-- Filters the quick fix list using FZF
-- @param destructive Whether to overwrite the current quick fix list
local function filter_qf(destructive)
  local fzf = Fzf:create(function(ref, lines)
    local qf_list = nvim.fn.getqflist()
    local rows_to_keep = utils.map(lines, function(line) return string.sub(line, 1, 1) end)
    local new_results = utils.filter(qf_list, function(item, i) return vim.tbl_contains(rows_to_keep, tostring(i)) end)

    if not destructive then
      nvim.fn.setqflist(new_results)
    else
      nvim.fn.setqflist({}, 'r', { items = new_results })
    end
  end, true)

  fzf:execute {
    source = get_list(),
    window = Fzf.float_window(function() fzf:unsubscribe() end),
    options = { '--multi' }
  } 
end

return {
  filter = filter_qf
}
