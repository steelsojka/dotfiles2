(module dotfiles.module.plugin.compe)

(local compe (require :compe))

(compe.setup
  {:enabled true
   :autocomplete true
   :source {:path true
            :buffer true
            :vsnip false
            :nvim_lsp true
            :nvim_lua true}})
