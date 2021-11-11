(module dotfiles.module.plugin.slime
  {require {nvim aniseed.nvim}})

(defn setup []
  (set nvim.g.slime_target "neovim"))
