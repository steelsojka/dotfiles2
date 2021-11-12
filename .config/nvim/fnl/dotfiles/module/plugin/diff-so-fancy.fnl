(module dotfiles.module.plugin.diff-so-fancy)

(defn run []
  (->> conf.install_path
       (string.format "!ln -s %s/diff-so-fancy ~/bin/diff-so-fancy")
       (vim.cmd)))
