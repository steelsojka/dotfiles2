(module dotfiles.module.lsp
  {require {lsp dotfiles.lsp.configs}})

(local nvim-lsp (require "lspconfig"))

(each [server config (pairs lsp.configs)]
  (when (. nvim-lsp server)
    (-> (lsp.get-config config)
        ((. nvim-lsp server "setup")))))
