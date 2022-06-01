(module dotfiles.health
  {require {nvim aniseed.nvim}})

(defn- check-exec [name]
  (if (= (nvim.fn.executable name) 1)
    (nvim.fn.health#report_ok name)
    (nvim.fn.health#report_error (string.format "%s is not installed" "Please install %s" name name))))

(defn check []
  (nvim.fn.health#report_start "Binaries")
  (check-exec "lazygit")
  (check-exec "node")
  (check-exec "fd")
  (check-exec "fzf")
  (check-exec "w3m"))
