(module dotfiles.module.plugin.markdown-preview)

(defn run []
  (vim.cmd "call mkdp#util#install()"))
