local mappings = require 'steelvim/utils/mappings'
local nvim = require 'nvim'
local Fzf = require 'steelvim/fzf/fzf'

local find_fzf = Fzf:create 'Dirvish'

local function fzf_directories(starting_point)
  find_fzf:execute {
    source = ([[find "%s" -type d]]):format(starting_point),
    options = { [[--preview=ls -la {}]]}
  }
end

local function fzf_files(starting_point)
  find_fzf:execute(vim.fn['fzf#vim#with_preview'] {
    source = ([[rg --hidden --files %s]]):format(starting_point)
  })
end

return function()
  nvim.ex.setlocal 'nospell'
  mappings.init_buffer_mappings {
    g = { name = '+goto' }
  }

  mappings.register_buffer_mappings {
    ['n md'] = { function()
      local filehead = vim.fn.expand '<cfile>:h'
      local dirname = vim.fn.input 'Create directory: '

      if filename ~= '' then
        nvim.command(('!mkdir %s/%s'):format(filehead, dirname))
        nvim.input 'R'
      end
    end, description = 'Make directory' },
    ['n mf'] = { function()
      local filehead = vim.fn.expand '<cfile>:h'
      local filename = vim.fn.input 'Create file: '

      if filename ~= '' then
        nvim.command(('!touch %s/%s'):format(filehead, filename))
        nvim.input 'R'
      end
    end, description = 'Create file' },
    ['n mr'] = { function()
      local filename = vim.fn.expand '<cfile>:t'
      local filepath = vim.fn.expand '<cfile>'
      local filehead = vim.fn.expand '<cfile>:h'
      local new_name = vim.fn.input('Rename file: ', filename)

      if new_name ~= '' and new_name ~= filename then
        nvim.command(('!mv %s %s/%s'):format(filepath, filehead, new_name))
        nvim.input 'R'
      end
    end, description = 'Rename' },
    ['n mm'] = { function()
      local filepath = vim.fn.expand '<cfile>'
      local new_path = vim.fn.input('Move file to : ', filepath)

      if new_path ~= '' and new_path ~= filepath then
        nvim.command(('!mv %s %s'):format(filepath, new_path))
        nvim.input 'R'
      end
    end, description = 'Move' },
    ['n mc'] = { function()
      local filepath = vim.fn.expand '<cfile>'
      local new_path = vim.fn.input('Copy file to : ', filepath)

      if new_path ~= '' and new_path ~= filepath then
        nvim.command(('!cp %s %s'):format(filepath, new_path))
        nvim.input 'R'
      end
    end, description = 'Copy' },
    ['n mk'] = { function()
      local filepath = vim.fn.expand '<cfile>'
      local confirmed = vim.fn.confirm(('Delete %s?'):format(filepath))

      if confirmed == 1 then
        nvim.command(('!rm -r %s'):format(filepath))
        nvim.input 'R'
      end
    end, description = 'Delete' },
    ['n mgd'] = { function() fzf_directories(vim.fn.expand '%:p:h') end, description = 'Child directory' },
    ['n mgD'] = { function() fzf_directories(vim.fn.getcwd()) end, description = 'Project directory' },
    ['n mgf'] = { function() fzf_files(vim.fn.expand '%:p:h') end, description = 'Child file' },
    ['n mgF'] = { function() fzf_files(vim.fn.getcwd()) end, description = 'Project file' },
    ['nH'] = { [[<Plug>(dirvish_up)]] },
    ['n q'] = { [[gq]], noremap = false },
    ['n Q'] = { [[gq]], noremap = false }
  }
end
