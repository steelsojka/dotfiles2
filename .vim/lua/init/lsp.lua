local lsp = require 'nvim_lsp'
local completion = require 'completion'
local diagnostic = require 'diagnostic'

local function global_on_attach()
  completion.on_attach()
  diagnostic.on_attach()
end

-- Typescript
lsp.tsserver.setup { on_attach = global_on_attach }

-- JSON
lsp.jsonls.setup { on_attach = global_on_attach }

-- HTML
lsp.html.setup { on_attach = global_on_attach }

-- VimL
lsp.vimls.setup { on_attach = global_on_attach }

-- Bash
lsp.bashls.setup { on_attach = global_on_attach }
