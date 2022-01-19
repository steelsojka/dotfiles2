(module dotfiles.lsp.logging)

(defn set-logging-level []
  (let [levels (vim.tbl_keys vim.log.levels)]
    (vim.ui.select levels nil #(vim.lsp.set_log_level $))))
