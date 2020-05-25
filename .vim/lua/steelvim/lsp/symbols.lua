local lsp_utils = require 'steelvim/lsp/utils'
local utils = require 'steelvim/utils/utils'
local Fzf = require 'steelvim/fzf/fzf'

local M = {}

M._fzf_symbol_handler = Fzf:create(function(ref, results)
  if #results > 1 then
    local locations = utils.map(results, function(item)
      return M._parse_symbol_to_location(item)
    end)

    local items = vim.lsp.util.locations_to_items(locations)

    vim.lsp.util.set_qflist(items)
    vim.api.nvim_command("copen")
  else
    vim.lsp.util.jump_to_location(M._parse_symbol_to_location(results[1]))
  end
end, true)

function M._parse_symbol_to_location(result)
  local parsed = vim.split(result, ' ')
  local loc = vim.split(parsed[3], ':')

  return lsp_utils.file_to_location(parsed[1], tonumber(loc[1]) - 1, tonumber(loc[2]) - 1)
end

function M.symbol_callback(_, _, result, _, bufnr)
  if not result or vim.tbl_isempty(result) then return end

  local items = vim.lsp.util.symbols_to_items(result)

  M._fzf_symbol_handler:execute {
    options = { "--multi", "--ansi", "--with-nth", "2..", "--tabstop", "1", "-n", "3,1..2" };
    source = utils.map(items, function(item)
      local symbol = item.text:match("] (.*)")

      return string.format([[%s %s %d:%d %s]], item.filename, item.kind, item.lnum, item.col, symbol)
    end);
    window = Fzf.float_window();
  }
end


return M
