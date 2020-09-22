(module dotfiles.files
  {require {nvim aniseed.nvim
            ws dotfiles.workspace
            fzf dotfiles.fzf}})

(defn fzf-files [query fullscreen history-fn]
  (print :test)
  (let [local-folder (ws.create-workspace (nvim.fn.expand "%:p:h"))
        spec {:options ["--history"
                        (.. local-folder "/" (or history-fn "fzf-history-files"))]}]
    (if (= fullscreen 1)
      (nvim.fn.fzf#vim#files query (nvim.fn.fzf#vim#with_preview spec "up:80%") 1)
      (nvim.fn.fzf#vim#files query (nvim.fn.fzf#vim#with_preview spec) 0))))
