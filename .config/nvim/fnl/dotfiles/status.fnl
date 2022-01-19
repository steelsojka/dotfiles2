(module dotfiles.status)

(defn lsp []
  (if (> (length (vim.lsp.buf_get_clients)) 0)
    (let [lsp-status (require "lsp-status")]
      (lsp-status.status))
    ""))
