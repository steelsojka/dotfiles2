local mappings = require 'mappings'
local fzf_quickfix = require 'fzf/quickfix'
local Funcref = require 'funcref'
local nvim = require 'nvim'

local delete_quickfix_item = function(first_line, last_line)
  local qf_list = nvim.fn.getqflist()
  local i = first_line
  
  while i <= last_line do
    table.remove(qf_list, first_line)
    i = i + 1
  end

  nvim.fn.setqflist({}, 'r', { items = qf_list })
end

return function()
  mappings.register_buffer_mappings {
    ['n mn'] = { [[:cnewer<CR>]], description = 'Newer list' },
    ['n mp'] = { [[:colder<CR>]], description = 'Older list'  },
    ['n ml'] = { [[:chistory<CR>]], description = 'List history' },
    ['n mf'] = { function() fzf_quickfix.filter(true) end, description = 'Filter (destructive)' },
    ['n mF'] = { function() fzf_quickfix.filter(false) end, description = 'Filter' },
    ['n md'] = { function()
      local line = nvim.fn.getpos('.')[2]

      delete_quickfix_item(line, line)
    end, description = 'Delete item' },
    ['v md'] = { function() 
      delete_quickfix_item(nvim.fn.getpos("'<")[2], nvim.fn.getpos("'>")[2])
    end, description = 'Delete selected items' }
  }
end
