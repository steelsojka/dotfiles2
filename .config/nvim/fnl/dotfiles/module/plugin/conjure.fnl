(module dotfiles.module.plugin.conjure
  {require {nvim aniseed.nvim
            keymap dotfiles.keymap}})

(defn setup []
  (set nvim.g.conjure#mapping#prefix "<leader>m"))

(defn init-local-mappings []
  (keymap.init-buffer-mappings
    {:l {:name "+log"}
     :e {:name "+eval"}
     :g {:name "+goto"}})
  (keymap.register-buffer-mappings
    {"n mls" {:description "H split"}
     "n mlt" {:description "New tab"}
     "n mlq" {:description "Close"}
     "n mlv" {:description "V split"}
     "n mee" {:description "Form under cursor"}
     "n mer" {:description "Root form"}
     "n mem" {:description "At mark"}
     "n mew" {:description "Work under cursor"}
     "n mef" {:description "File from disk"}
     "n mgd" {:description "Go to definition"}
     "n mE" {:description "Motion"}
     "n meb" {:description "File buffer"}}))
