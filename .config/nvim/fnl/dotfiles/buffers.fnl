(module dotfiles.buffers
  {require {nvim aniseed.nvim
            core aniseed.core}})

(defn trim-trailing-whitespace []
  (let [saved (nvim.fn.winsaveview)]
    (nvim.command "keeppatterns %s/\\s\\+$//e")
    (nvim.fn.winrestview saved)))
