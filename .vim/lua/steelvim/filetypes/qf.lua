local mappings = require 'steelvim/utils/mappings'
local quickfix = require 'steelvim/quickfix'
local Funcref = require 'steelvim/utils/funcref'
local nvim = require 'nvim'

return function()
  mappings.register_buffer_mappings {
    ['n mn'] = { [[:cnewer<CR>]], description = 'Newer list' },
    ['n mp'] = { [[:colder<CR>]], description = 'Older list'  },
    ['n ml'] = { [[:chistory<CR>]], description = 'List history' },
    ['n mF'] = { function() quickfix.filter_qf(true) end, description = 'Filter (destructive)' },
    ['n mf'] = { function() quickfix.filter_qf(false) end, description = 'Filter' },
    ['n md'] = { function()
      local line = vim.fn.getpos('.')[2]

      quickfix.delete_item(line, line)
    end, description = 'Delete item' },
    ['v md'] = { function() 
      quickfix.delete_item(vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2])
    end, description = 'Delete selected items' }
  }
end
