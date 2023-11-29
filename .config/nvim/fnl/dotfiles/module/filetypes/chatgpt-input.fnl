(module dotfiles.module.filetypes.chatgpt-input
  {require {keymap dotfiles.keymap}})

(fn []
  (keymap.register-buffer-mappings
    {"y" {:name "+yank"}
     "yy" "Yank last"
     "yk" "Yank last code"
     "s" {:name "+session"}
     "sn" "New session"
     "ss" "Select session"
     "sr" "Rename session"
     "sd" "Delete session"
     "w" "Cycle windows"
     "M" "Cycle modes"
     "m" {:name "+message"}
     "mn" "Next message"
     "md" "Draft message"
     "me" "Edit message"
     "K" "Stop generating"
     "t" {:name "+toggle"}
     "tr" "Toggle message role"
     "tR" "Toggle system role"
     "ts" "Toggle settings"
     "<CR>" "Accept"
     "td" "Toggle diff"
     "i" "Use output as input"}
    {:prefix "<leader>m"}))
