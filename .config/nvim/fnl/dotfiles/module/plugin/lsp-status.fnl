(module dotfiles.module.plugin.lsp-status)

(defn setup []
  (print "HELLO")
  (let [lsp-status (require "lsp-status")]
    (lsp-status.register_progress)))
