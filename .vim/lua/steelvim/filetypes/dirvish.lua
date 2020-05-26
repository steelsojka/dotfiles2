local find_fzf = steel.fzf:create 'Dirvish'

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
  steel.ex.setlocal("nospell")
  steel.mappings.init_buffer_mappings {
    g = { name = '+goto' }
  }

  steel.mappings.register_buffer_mappings {
    ['n md'] = { function()
      local filehead = vim.fn.expand '<cfile>:h'
      local dirname = vim.fn.input 'Create directory: '

      if filename ~= '' then
        steel.command(('!mkdir %s/%s'):format(filehead, dirname))
        vim.api.nvim_input 'R'
      end
    end, description = 'Make directory' },
    ['n mf'] = { function()
      local filehead = vim.fn.expand '<cfile>:h'
      local filename = vim.fn.input 'Create file: '

      if filename ~= '' then
        steel.command(('!touch %s/%s'):format(filehead, filename))
        vim.api.nvim_input 'R'
      end
    end, description = 'Create file' },
    ['n mr'] = { function()
      local filename = vim.fn.expand '<cfile>:t'
      local filepath = vim.fn.expand '<cfile>'
      local filehead = vim.fn.expand '<cfile>:h'
      local new_name = vim.fn.input('Rename file: ', filename)

      if new_name ~= '' and new_name ~= filename then
        steel.command(('!mv %s %s/%s'):format(filepath, filehead, new_name))
        vim.api.nvim_input 'R'
      end
    end, description = 'Rename' },
    ['n mm'] = { function()
      local filepath = vim.fn.expand '<cfile>'
      local new_path = vim.fn.input('Move file to : ', filepath)

      if new_path ~= '' and new_path ~= filepath then
        steel.command(('!mv %s %s'):format(filepath, new_path))
        vim.api.nvim_input 'R'
      end
    end, description = 'Move' },
    ['n mc'] = { function()
      local filepath = vim.fn.expand '<cfile>'
      local new_path = vim.fn.input('Copy file to : ', filepath)

      if new_path ~= '' and new_path ~= filepath then
        steel.command(('!cp %s %s'):format(filepath, new_path))
        vim.api.nvim_input 'R'
      end
    end, description = 'Copy' },
    ['n mk'] = { function()
      local filepath = vim.fn.expand '<cfile>'
      local confirmed = vim.fn.confirm(('Delete %s?'):format(filepath))

      if confirmed == 1 then
        steel.command(('!rm -r %s'):format(filepath))
        vim.api.nvim_input 'R'
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
