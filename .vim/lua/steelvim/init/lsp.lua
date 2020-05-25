local lsp = require 'nvim_lsp'
local root_pattern = require 'nvim_lsp/util'.root_pattern


-- Typescript
lsp.tsserver.setup(steel.lsp.get_config {
  -- Enable for debugging.
  -- cmd = {
  --   'typescript-language-server',
  --   '--stdio',
  --   '--tsserver-log-file', 'tsserver.log',
  --   '--tsserver-log-verbosity', 'verbose'
  -- },
  -- Don't use package.json to resolve root because monorepos don't like it.
  root_dir = root_pattern('.git', 'tsconfig.json');
})

-- JSON
lsp.jsonls.setup(steel.lsp.get_config())

-- HTML
lsp.html.setup(steel.lsp.get_config())

-- VimL
lsp.vimls.setup(steel.lsp.get_config())

-- CSS
lsp.cssls.setup(steel.lsp.get_config())

-- Bash
lsp.bashls.setup(steel.lsp.get_config())


-- Lua
-- lsp.sumneko_lua.setup { on_attach = global_on_attach }

-- Angular
-- lsp.angularls.setup { on_attach = global_on_attach }

lsp.jdtls.setup(steel.lsp.get_config {
  init_options = {
    jvm_args = {
      "-javaagent:/usr/local/share/lombok/lombok.jar",
      "-Xbootclasspath/a:/usr/local/share/lombok/lombok.jar"
    };
  };
})
