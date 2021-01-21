(module dotfiles.module.filetypes.java
  {require {nvim aniseed.nvim}})

(fn []
  (set vim.bo.shiftwidth 2)
  (local jdtls (require :jdtls))
  (jdtls.start_or_attach {:cmd ["jdtls"]}))
