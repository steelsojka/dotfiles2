(module dotfiles.module.filetypes.http
  {require {keymap dotfiles.keymap}})

(fn []
  (keymap.register-buffer-mappings
    {"n mr" {:do "<Plug>RestNvim" :description "Run request"}
     "n mp" {:do "<Plug>RestNvimPreview" :description "Preview request"}
     "n mR" {:do "<Plug>RestNvimLast" :description "Run last request"}}))
