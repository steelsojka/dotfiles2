(module dotfiles.module.plugin.lsp-status)

(defn configure []
  (let [lsp-status (require "lsp-status")]
    (lsp-status.register_progress)))
