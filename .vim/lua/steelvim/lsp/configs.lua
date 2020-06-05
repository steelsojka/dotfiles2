local lsp = require "nvim_lsp"
local root_pattern = require "nvim_lsp/util".root_pattern

local M = {
  tsserver = {
    -- Enable for debugging.
    -- cmd = {
    --   "typescript-language-server",
    --   "--stdio",
    --   "--tsserver-log-file", "tsserver.log",
    --   "--tsserver-log-verbosity", "verbose"
    -- },
    -- Don't use package.json to resolve root because monorepos don't like it.

    root_dir = root_pattern(".git", "tsconfig.json");
    settings = {
      typescript = {
        preferences = {
          importModuleSpecifier = "non-relative";
          quoteStyle = "single";
        };
      };
    };
  };
  jsonls = {};
  html = {};
  vimls = {};
  cssls = {};
  bashls = {};
  jdtls = {
    init_options = {
      jvm_args = {
        "-javaagent:/usr/local/share/lombok/lombok.jar",
        "-Xbootclasspath/a:/usr/local/share/lombok/lombok.jar"
      };
    };
  };
}

return M
