(module dotfiles.health)

(defn- check-exec [name]
  (if (= (vim.fn.executable name) 1)
    (vim.fn.health#report_ok name)
    (vim.fn.health#report_error (string.format "%s is not installed. Please install %s" name name))))

(defn check []
  (vim.fn.health#report_start "Binaries")
  (check-exec "lazygit")
  (check-exec "node")
  (check-exec "fd")
  (check-exec "fzf")
  (check-exec "w3m"))
