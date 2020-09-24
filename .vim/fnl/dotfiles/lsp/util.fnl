(module dotfiles.lsp.fzf
  {require {nvim aniseed.nvim
            core aniseed.core}})

(defn file-to-location [filepath lnum col]
  (uri-to-location (vim.uri_from_fname filepath) lnum col))

(defn uri-to-location [uri lnum col]
  {: uri :range {:start {:line lnum :character col}}})

(defn handle-location-items [data loc-creator]
  (if (> (length data) 1)
    (do
      (-> (core.map #(loc-creator $1) data)
          (vim.lsp.util.locations_to_items)
          (vim.lsp.util.set_qflist))
      (nvim.ex.copen))
    (= (length data) 1)
    (-> (. data 1)
        (loc-creator)
        (vim.lsp.util.jump_to_location))))
