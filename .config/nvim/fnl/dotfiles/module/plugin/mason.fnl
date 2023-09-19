(module dotfiles.module.plugin.mason
  {require {lsp-configs dotfiles.lsp.configs}})

(defn configure []
  (let [mason (require "mason")
        mason-lsp (require "mason-lspconfig")
        server-configs (require "lspconfig.configs")]
    (tset server-configs :lwc {:default_config
                               {:cmd ["lwc-language-server"]
                                :filetypes ["html" "typescript" "javascript"]}})
    (mason.setup)
    (mason-lsp.setup {:automatic_installation true})
    (lsp-configs.setup)))
