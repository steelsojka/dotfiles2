(module dotfiles.module.filetypes.fennel
  {require {nvim aniseed.nvim
            conjure dotfiles.module.plugin.conjure}})

(fn []
  (set vim.bo.shiftwidth 2)
  (conjure.init-local-mappings))
