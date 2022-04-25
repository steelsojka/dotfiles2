(module dotfiles.module.plugin.lsp-status)

(defn setup []
  (let [lsp-status (require "lsp-status")]
    (lsp-status.register_progress)))
