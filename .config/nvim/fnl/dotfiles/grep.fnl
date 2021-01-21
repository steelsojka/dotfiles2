(module dotfiles.grep
  {require {nvim aniseed.nvim
            ws dotfiles.workspace}})

(defn flygrep [query cwd fullscreen args]
  (let [local-folder (ws.create-workspace (nvim.fn.expand "%:p:h"))
        custom-args (table.concat (or args {}) " ")
        command "rg --column --line-number --no-heading --color=always --smart-case %s %s || true"
        initial-cmd (string.format command custom-args (nvim.fn.shellescape query))
        reload-cmd (string.format command custom-args "{q}")
        spec {:dir cwd
              :options ["--phony" "--query" query "--bind"
                        (string.format "change:reload:%s" reload-cmd)
                        "--history" (.. local-folder "/fzf-history-grep")]}]
    (if (= fullscreen 1)
      (nvim.fn.fzf#vim#grep initial-cmd 1 (vim.fn.fzf#vim#with_preview spec "up:80%") 1)
      (nvim.fn.fzf#vim#grep initial-cmd 1 (vim.fn.fzf#vim#with_preview spec) 0))))

(defn grep [query dir fullscreen args]
  (let [options (if (= fullscreen 1)
                  (nvim.fn.fzf#vim#with_preview {: dir} "up:80%")
                  (nvim.fn.fzf#vim#with_preview {: dir} "right:50%" "?"))
        custom-args (table.concat (or args {}) " ")]
    (nvim.fn.fzf#vim#grep
      (string.format "rg --column --line-number --no-heading --color=always --smart-case %s %s"
                     custom-args
                     (nvim.fn.shellescape query))
      1
      options
      fullscreen)))
