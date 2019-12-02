local mappings = require 'mappings'
local nvim = require 'nvim'

return function()
  nvim.ex.setlocal('nospell')

  mappings.register_buffer_mappings {
    ['n md'] = { [[:!mkdir %]], description = 'Make directory' },
    ['n mf'] = { function()
      local filehead = nvim.fn.expand('<cfile>:h')
      local filename = nvim.fn.input('Create file: ')

      if filename ~= '' then
        nvim.command('!touch ' .. filehead .. '/' .. filename)
        nvim.input('R')
      end
    end, description = 'Create file' },
    ['n mr'] = { function()
      local filename = nvim.fn.expand('<cfile>:t')
      local filepath = nvim.fn.expand('<cfile>')
      local filehead = nvim.fn.expand('<cfile>:h')
      local new_name = nvim.fn.input('Rename file: ', filename)

      if new_name ~= '' and new_name ~= filename then
        nvim.command('!mv ' .. filepath .. ' ' .. filehead .. '/' .. new_name)
        nvim.input('R')
      end
    end, description = 'Rename' },
    ['n mm'] = { function()
      local filepath = nvim.fn.expand('<cfile>')
      local new_path = nvim.fn.input('Move file to : ', filepath)

      if new_path ~= '' and new_path ~= filepath then
        nvim.command('!mv ' .. filepath .. ' ' .. new_path)
        nvim.input('R')
      end
    end, description = 'Move' },
    ['n mc'] = { function()
      local filepath = nvim.fn.expand('<cfile>')
      local new_path = nvim.fn.input('Copy file to : ', filepath)

      if new_path ~= '' and new_path ~= filepath then
        nvim.command('!cp ' .. filepath .. ' ' .. new_path)
        nvim.input('R')
      end
    end, description = 'Copy' },
    ['n mk'] = { function()
      local filepath = nvim.fn.expand('<cfile>')
      local confirmed = nvim.fn.confirm('Delete ' .. filepath .. '?') 

      if confirmed then
        nvim.command('!rm -r ' .. filepath)
        nvim.input('R')
      end
    end, description = 'Delete' },
    ['nK'] = { [[<Plug>(dirvish_up)]], noremap = false },
    ['n q'] = { [[gq]], noremap = false },
    ['n Q'] = { [[gq]], noremap = false }
  }
end
