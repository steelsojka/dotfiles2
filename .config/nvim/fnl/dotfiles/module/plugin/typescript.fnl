(module dotfiles.module.plugin.typescript
  {require {nvim aniseed.nvim}})

(set nvim.g.typescript_compiler_binary "node_modules/.bin/tsc")
(set nvim.g.typescript_compiler_options "--noEmit")
