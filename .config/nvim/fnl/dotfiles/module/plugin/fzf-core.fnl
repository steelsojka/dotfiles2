(module dotfiles.module.plugin.fzf)

(defn run [conf]
  (->> conf.install_path
       (string.format "!%s/install --all")
       (vim.cmd))
  (->> conf.install_path
       (string.format "!ln -s %s ~/.fzf")
       (vim.cmd)))
