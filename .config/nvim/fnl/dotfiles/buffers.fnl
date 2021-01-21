(module dotfiles.buffers
  {require {nvim aniseed.nvim
            core aniseed.core
            fzf dotfiles.fzf}})

(def- fzf-del-buf-handler
  (fzf.create (fn [_ buffers]
                (each [_ v (pairs buffers)]
                  (local buf (string.match v "^%[([0-9]+)%]"))
                  (when (~= buf nil)
                    (nvim.ex.bw buf))))
              {:handle-all true}))

(defn- get-listed-buffers []
  (core.filter
    (fn [val]
      (and (= (nvim.fn.buflisted val) 1) (~= (nvim.fn.getbufvar val "&filetype") :qf)))
    (nvim.fn.range 1 (nvim.fn.bufnr "$"))))

(defn- format-buflist [buflist]
  (core.map
    #(let [name (nvim.fn.bufname $1)
           modified (if (= (nvim.fn.getbufvar $1 "&modified") 1) " [+]" "")
           readonly (if (= (nvim.fn.getbufvar $1 "&modifiable") 1) "" " [RO]")
           new-name (if (= (length name) 0) "[No Name]" (nvim.fn.fnamemodify name ":p:~:."))]
      (string.format "[%s] %s\t%s" $1 new-name (.. modified readonly)))))

(defn delete-buffers-fzf []
  (fzf-del-buf-handler.execute
    {:source (-> (get-listed-buffers) (format-buflist))
     :options ["--multi" "--prompt=Kill> " "--nth=2"]}))

(defn trim-trailing-whitespace []
  (let [saved (nvim.fn.winsaveview)]
    (nvim.command "keeppatterns %s/\\s\\+$//e")
    (nvim.fn.winrestview saved)))
