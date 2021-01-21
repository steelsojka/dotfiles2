(module dotfiles.health
  {require {nvim aniseed.nvim}})

(defn check []
  (nvim.fn.health#report_start "Binaries")
  (if (= (nvim.fn.executable "lazygit") 1)
    (nvim.fn.health#report_ok "lazygit")
    (nvim.fn.health#report_error "lazygit is not installed" "Please install lazygit"))
  (if (= (nvim.fn.executable "node") 1)
    (nvim.fn.health#report_ok "node")
    (nvim.fn.health#report_error "NodeJS is not installed" "Please install it")))
