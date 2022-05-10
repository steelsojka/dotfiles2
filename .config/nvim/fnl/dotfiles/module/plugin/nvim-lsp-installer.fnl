(module dotfiles.module.plugin.nvim-lsp-installer
  {require {lsp-configs dotfiles.lsp.configs}})

(defn configure []
  (let [lsp-installer (require "nvim-lsp-installer")]
    (lsp-installer.setup)
    (lsp-configs.setup)))
