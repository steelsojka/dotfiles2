(module dotfiles.module.plugin.fzf-core)

(defn build [plugin]
  (print (vim.inspect plugin))
  (->> plugin.dir
       (string.format "!%s/install --all")
       (vim.cmd))
  (->> plugin.dir
       (string.format "!ln -s %s ~/.fzf")
       (vim.cmd)))
