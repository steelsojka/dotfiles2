(module dotfiles.module.lsp
  {require {lsp dotfiles.lsp.configs}})

(local nvim-lsp (require "nvim_lsp"))

(each [server config (pairs lsp.configs)]
  (-> (lsp.get-config config)
      ((. nvim-lsp server "setup"))))
