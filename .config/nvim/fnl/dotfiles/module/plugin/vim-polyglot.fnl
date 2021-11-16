(module dotfiles.module.plugin.vim-polyglot)

(defn setup []
  (set vim.g.polyglot_disabled ["sensible" "typescript"]))
