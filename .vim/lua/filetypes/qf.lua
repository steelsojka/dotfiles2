local mappings = require 'utils/mappings'
local quickfix = require 'quickfix'
local Funcref = require 'utils/funcref'
local nvim = require 'nvim'

return function()
  mappings.register_buffer_mappings {
    ['n mn'] = { [[:cnewer<CR>]], description = 'Newer list' },
    ['n mp'] = { [[:colder<CR>]], description = 'Older list'  },
    ['n ml'] = { [[:chistory<CR>]], description = 'List history' },
    ['n mf'] = { function() quickfix.filter(true) end, description = 'Filter (destructive)' },
    ['n mF'] = { function() quickfix.filter(false) end, description = 'Filter' },
    ['n md'] = { function()
      local line = nvim.fn.getpos('.')[2]

      quickfix.delete_item(line, line)
    end, description = 'Delete item' },
    ['v md'] = { function() 
      quickfix.delete_item(nvim.fn.getpos("'<")[2], nvim.fn.getpos("'>")[2])
    end, description = 'Delete selected items' }
  }
end
