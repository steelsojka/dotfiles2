local lsp = require 'nvim_lsp'
local lsp_util = require 'nvim_lsp/util'
local nvim = require 'nvim'
local completion = require 'completion'
local diagnostic = require 'diagnostic'
local jobs = require 'utils/jobs'
local utils = require 'utils/utils'

local function global_on_attach()
  completion.on_attach()
  diagnostic.on_attach()
end

-- Typescript
lsp.tsserver.setup {
  on_attach = global_on_attach;
  callbacks = {
    ['textDocument/formatting'] = function(err, method, params, client_id)
      -- print(method, vim.inspect(params), client_id)
      local cmd = 'prettier --stdin'
      local buffer = nvim.win_get_buf(0)
      local buf_lines = nvim.fn.getbufline(buffer, 1, '$')
      local job = jobs.job_start(cmd)

      job:subscribe({
        error = function(err)
          print(err)
        end;
        next = function(lines)
          nvim.buf_set_lines(buffer, 0, -1, false, lines)
        end;
      })

      job:next(utils.join(buf_lines, '\n'))
      job:complete()
    end
  };
  -- Enable for debugging.
  -- cmd = {
  --   'typescript-language-server',
  --   '--stdio',
  --   '--tsserver-log-file', 'tsserver.log',
  --   '--tsserver-log-verbosity', 'verbose'
  -- },
  -- Don't use package.json to resolve root because monorepos don't like it.
  root_dir = lsp_util.root_pattern('.git', 'tsconfig.json');
}

-- JSON
lsp.jsonls.setup { on_attach = global_on_attach }

-- HTML
lsp.html.setup { on_attach = global_on_attach }

-- VimL
lsp.vimls.setup { on_attach = global_on_attach }

-- CSS
lsp.cssls.setup { on_attach = global_on_attach }

-- Bash
lsp.bashls.setup { on_attach = global_on_attach }

-- Lua
-- lsp.sumneko_lua.setup { on_attach = global_on_attach }

-- Angular
-- lsp.angularls.setup { on_attach = global_on_attach }
