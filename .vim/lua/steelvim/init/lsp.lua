local lsp = require 'nvim_lsp'
local lsp_util = require 'nvim_lsp/util'
local nvim = require 'nvim'
local completion = require 'completion'
local diagnostic = require 'diagnostic'
local path = lsp_util.path 

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

lsp.jdtls.setup {
  on_attach = global_on_attach;
  init_options = {
    jvm_args = {
      "-javaagent:/usr/local/share/lombok/lombok.jar",
      "-Xbootclasspath/a:/usr/local/share/lombok/lombok.jar"
    };
  };
}
