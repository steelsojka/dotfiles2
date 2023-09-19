(module dotfiles.module.filetypes.http
  {require {keymap dotfiles.keymap}})

(fn []
  (keymap.register-buffer-mappings
    {"mr" {:do "<Plug>RestNvim" :description "Run request"}
     "mp" {:do "<Plug>RestNvimPreview" :description "Preview request"}
     "mR" {:do "<Plug>RestNvimLast" :description "Run last request"}}
    {:prefix "<leader>"}))
