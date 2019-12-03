local mappings = require 'utils/mappings'
local nvim = require 'nvim'

return function()
  nvim.bo.makeprg = nvim.g.typescript_compiler_binary .. ' ' .. nvim.g.typescript_compiler_options .. ' $*'

  mappings.register_buffer_mappings {
    ['n mc'] = { [[<Cmd>Make -p tsconfig.json<CR>]], description = 'Compile' },
  }
end
