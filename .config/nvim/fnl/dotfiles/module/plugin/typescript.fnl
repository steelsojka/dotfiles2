(module dotfiles.module.plugin.typescript)

(defn setup []
  (set vim.g.typescript_compiler_binary "node_modules/.bin/tsc")
  (set vim.g.typescript_compiler_options "--noEmit"))
