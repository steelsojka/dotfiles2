(module dotfiles.module.plugin.nvim-lsp-installer
  {require {lsp-configs dotfiles.lsp.configs}})

(defn configure []
  (let [lsp-installer (require "nvim-lsp-installer")
        server-configs (require "lspconfig.configs")]
    (tset server-configs :lwc {:default_config
                               {:cmd ["lwc-language-server"]
                                :filetypes ["html" "typescript" "javascript"]}})
    (lsp-installer.setup)
    (lsp-configs.setup)))
