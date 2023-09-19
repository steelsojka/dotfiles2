(module dotfiles.module.plugin.conjure
  {require {keymap dotfiles.keymap}})

(defn setup []
  (set vim.g.conjure#mapping#prefix "<leader>m"))

(defn init-local-mappings []
  (keymap.register-buffer-mappings
    {"ml" "+log"
     "me" "+eval"
     "mg" "+goto"
     "mls" "H split"
     "mlt" "New tab"
     "mlq" "Close"
     "mlv" "V split"
     "mee" "Form under cursor"
     "mer" "Root form"
     "mem" "At mark"
     "mew" "Work under cursor"
     "mef" "File from disk"
     "mgd" "Go to definition"
     "mE" "Motion"
     "meb" "File buffer"}
    {:prefix "<leader>"}))
