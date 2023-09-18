(module dotfiles.module.plugin.diff-so-fancy)

(defn build [plugin]
  (->> plugin.dir
       (string.format "!ln -s %s/diff-so-fancy ~/bin/diff-so-fancy >/dev/null 2>&1")
       (vim.cmd)))
