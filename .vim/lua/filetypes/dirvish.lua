local mappings = require 'utils/mappings'
local nvim = require 'nvim'
local Fzf = require 'fzf/fzf'

local find_directory_fzf = Fzf:create 'Dirvish'

local function fzf_directories(starting_point)
  find_directory_fzf:execute {
    source = ([[find "%s" -type d]]):format(starting_point),
    options = { [[--preview=ls -la {}]]}
  }
end

return function()
  nvim.ex.setlocal('nospell')

  mappings.register_buffer_mappings {
    ['n md'] = { [[:!mkdir %]], description = 'Make directory' },
    ['n mf'] = { function()
      local filehead = nvim.fn.expand '<cfile>:h'
      local filename = nvim.fn.input 'Create file: '

      if filename ~= '' then
        nvim.command(('!touch %s/%s'):format(filehead, filename))
        nvim.input 'R'
      end
    end, description = 'Create file' },
    ['n mr'] = { function()
      local filename = nvim.fn.expand '<cfile>:t'
      local filepath = nvim.fn.expand '<cfile>'
      local filehead = nvim.fn.expand '<cfile>:h'
      local new_name = nvim.fn.input('Rename file: ', filename)

      if new_name ~= '' and new_name ~= filename then
        nvim.command(('!mv %s %s/%s'):format(filepath, filehead, new_name))
        nvim.input 'R'
      end
    end, description = 'Rename' },
    ['n mm'] = { function()
      local filepath = nvim.fn.expand '<cfile>'
      local new_path = nvim.fn.input('Move file to : ', filepath)

      if new_path ~= '' and new_path ~= filepath then
        nvim.command(('!mv %s %s'):format(filepath, new_path))
        nvim.input 'R'
      end
    end, description = 'Move' },
    ['n mc'] = { function()
      local filepath = nvim.fn.expand '<cfile>'
      local new_path = nvim.fn.input('Copy file to : ', filepath)

      if new_path ~= '' and new_path ~= filepath then
        nvim.command(('!cp %s %s'):format(filepath, new_path))
        nvim.input 'R'
      end
    end, description = 'Copy' },
    ['n mk'] = { function()
      local filepath = nvim.fn.expand '<cfile>'
      local confirmed = nvim.fn.confirm(('Delete %s?'):format(filepath))

      if confirmed then
        nvim.command(('!rm -r %s'):format(filepath))
        nvim.input 'R'
      end
    end, description = 'Delete' },
    ['n mg'] = { function() fzf_directories(nvim.fn.expand '%:p:h') end, description = 'Go to child directory' },
    ['n mG'] = { function() fzf_directories(nvim.fn.getcwd()) end, description = 'Go to project directory' },
    ['nH'] = { [[<Plug>(dirvish_up)]], noremap = false },
    ['n q'] = { [[gq]], noremap = false },
    ['n Q'] = { [[gq]], noremap = false }
  }
end
