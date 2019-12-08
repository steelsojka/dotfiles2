local nvim = require 'nvim'

-- Starts which key.
-- This will set local buffer mapping names to the local key "m"
-- @param visual Whether visual mode
local function start_which_key(visual)
  local success, local_which_key_dict = pcall(function() return nvim.b.local_which_key end)
  local which_key_dict = nvim.g.which_key_map

  which_key_dict['m'] = { name = '+local' }

  if success then
    which_key_dict['m'] = local_which_key_dict['m']
    which_key_dict['m'].name = '+local'
  end

  nvim.g.which_key_map = which_key_dict
  nvim.fn['which_key#register']('<Space>', 'g:which_key_map')
  nvim.command(([[%s " "]]):format(visual and 'WhichKeyVisual' or 'WhichKey'))
end

return {
  start = start_which_key
}
