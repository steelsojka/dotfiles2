(module dotfiles.files
  {require {util dotfiles.util}})

(defn to-relative-path [from-path to-path]
  (let [cmd (string.format "node -p %q"
                           (string.format "require('path').relative('%s', '%s/%s')"
                                          from-path
                                          (vim.fn.getcwd)
                                          to-path))
        lines (util.exec cmd)]
    (or (. lines 1) "")))
