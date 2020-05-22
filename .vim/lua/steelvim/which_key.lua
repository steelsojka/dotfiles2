local nvim = require 'nvim'

local M = {}

-- Starts which key.
-- This will set local buffer mapping names to the local key "m"
-- @param visual Whether visual mode
function M.start(visual)
  local success, local_which_key_dict = pcall(function() return nvim.b.local_which_key end)
  local which_key_dict = nvim.g.which_key_map

  which_key_dict['m'] = { name = '+local' }

  if success and type(local_which_key_dict) == 'table' then
    which_key_dict['m'] = local_which_key_dict['m']
    which_key_dict['m'].name = '+local'
  end

  nvim.g.which_key_map = which_key_dict
  vim.fn['which_key#register']('<Space>', 'g:which_key_map')
  nvim.command(([[%s " "]]):format(visual and 'WhichKeyVisual' or 'WhichKey'))
end

return M
