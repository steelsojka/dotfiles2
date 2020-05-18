local lsp = require 'nvim_lsp'
local util = require 'nvim_lsp/util'
local completion = require 'completion'
local diagnostic = require 'diagnostic'

local function global_on_attach()
  completion.on_attach()
  diagnostic.on_attach()
end

-- Typescript
lsp.tsserver.setup {
  on_attach = global_on_attach;
  -- Enable for debugging.
  -- cmd = {
  --   'typescript-language-server',
  --   '--stdio',
  --   '--tsserver-log-file', 'tsserver.log',
  --   '--tsserver-log-verbosity', 'verbose'
  -- },
  -- Don't use package.json to resolve root because monorepos don't like it.
  root_dir = util.root_pattern('.git', 'tsconfig.json');
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
lsp.sumneko_lua.setup { on_attach = global_on_attach }

-- lsp.angularls.setup { on_attach = global_on_attach }
