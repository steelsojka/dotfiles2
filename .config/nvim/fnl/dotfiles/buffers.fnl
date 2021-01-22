(module dotfiles.buffers
  {require {nvim aniseed.nvim
            core aniseed.core}})

(defn get-listed-buffers []
  (core.filter
    (fn [val]
      (and (= (nvim.fn.buflisted val) 1) (~= (nvim.fn.getbufvar val "&filetype") :qf)))
    (nvim.fn.range 1 (nvim.fn.bufnr "$"))))

(defn format-buf-entry [bufnr]
  (let [name (nvim.fn.bufname bufnr)
        modified (if (= (nvim.fn.getbufvar bufnr "&modified") 1) " [+]" "")
        readonly (if (= (nvim.fn.getbufvar bufnr "&modifiable") 1) "" " [RO]")
        new-name (if (= (length name) 0) "[No Name]" (nvim.fn.fnamemodify name ":p:~:."))]
    [(string.format "[%s]" bufnr)
     new-name
     (.. modified readonly)]))

(defn- format-buflist [buflist] (core.map #(format-buf-entry) buflist))

(defn trim-trailing-whitespace []
  (let [saved (nvim.fn.winsaveview)]
    (nvim.command "keeppatterns %s/\\s\\+$//e")
    (nvim.fn.winrestview saved)))
