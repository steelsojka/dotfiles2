local mappings = require 'mappings'
local nvim = require 'nvim'

LUA_FILETYPE_HOOKS = {
  dirvish = function()
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
  end;

  typescript = function()
    nvim.bo.makeprg = nvim.g.typescript_compiler_binary .. ' ' .. nvim.g.typescript_compiler_options .. ' $*'

    mappings.register_buffer_mappings {
      ['n mc'] = { [[<Cmd>Make -p tsconfig.json<CR>]], description = 'Compile' },
    }
  end;

  qf = function()
    mappings.register_buffer_mappings {
      ['n mn'] = { [[:cnewer<CR>]], description = 'Newer list' },
      ['n mp'] = { [[:colder<CR>]], description = 'Older list'  },
      ['n ml'] = { [[:chistory<CR>]], description = 'List history' },
      ['n mf'] = { [[:call steelvim#filter_qf(0)<CR>]], description = 'Filter (destructive)' },
      ['n mF'] = { [[:call steelvim#filter_qf(1)<CR>]], description = 'Filter' },
      ['n md'] = { [[:call steelvim#delete_qf_items(bufnr())<CR>]], description = 'Delete item' },
      ['v md'] = { [[:call steelvim#delete_qf_items(bufnr())<CR>]], description = 'Delete selected items' }
    }
  end;

  markdown = function()
    mappings.register_buffer_mappings {
      ['n mp'] = { [[<Plug>MarkdownPreview]], noremap = false, description = "Preview" }
    }
  end;

  java = function()
    nvim.bo.shiftwidth = 4 
  end;
}

local autocmds = {}

for filetype,fn in pairs(LUA_FILETYPE_HOOKS) do
  autocmds['LuaFiletypeHooks_' .. mappings.escape_keymap(filetype)] = {
    { 'FileType', filetype, ("lua LUA_FILETYPE_HOOKS[%q]()"):format(filetype) }
  }
end

mappings.create_augroups(autocmds)
