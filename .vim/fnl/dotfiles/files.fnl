(module dotfiles.files
  {require {nvim aniseed.nvim
            ws dotfiles.workspace
            win dotfiles.window
            fzf dotfiles.fzf
            util dotfiles.util}})

(defn fzf-files [query fullscreen history-fn]
  (let [local-folder (ws.create-workspace (nvim.fn.expand "%:p:h"))
        spec {:options ["--history"
                        (.. local-folder "/" (or history-fn "fzf-history-files"))]}]
    (if (= fullscreen 1)
      (nvim.fn.fzf#vim#files query (nvim.fn.fzf#vim#with_preview spec "up:80%") 1)
      (nvim.fn.fzf#vim#files query (nvim.fn.fzf#vim#with_preview spec) 0))))

(defn insert-relative-path [from-path]
  "Searches for a file in the project and inserts the relative path from the path provided.
  Requires node to be installed (which it will always be... let's be real)."
  (local fzf-instance
    (fzf.create
      (fn [ref other-path]
        (local cwd (nvim.fn.getcwd))
        (if cwd
          (do
            (local lines
              (util.exec
                (string.format "node -p \"require('path').relative('%s', '%s/%s')\""
                               from-path
                               cwd
                               other-path)))
            (var result (. lines 1))
            (if result
              (do
                ; Paths that don't move up need a './' in front.
                (when (~= (result:sub 1 1) ".")
                  (set result (.. "./" result)))
                ; Enter insert mode and type the text.
                (nvim.command (.. "normal! i" result))
                ; Move back to position and enter insert mode.
                (nvim.input "li"))
              (print "No path result!")))
          (print "No working directory!"))
        (ref:unsubscribe))))
  (fzf-instance.execute {:source "rg --files"
                         :window (win.float-window)})
  (nvim.input "<esc>i"))
