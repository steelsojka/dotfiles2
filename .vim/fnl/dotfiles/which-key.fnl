(module dotfiles.which-key
  {require {nvim aniseed.nvim}})

(defn start [visual]
  (let [(ok? local-wk-dict) (pcall #nvim.b.local_which_key)
        wk-dict nvim.g.which_key_map]
    (set wk-dict.m {:name "+local"})
    (when (and ok? (= (type local-wk-dict) :table))
      (set wk-dict.m local-wk-dict.m)
      (set wb-dict.m.name "+local"))
    (set nvim.g.which_key_map wk-dict)
    (nvim.fn.which_key#register "<Space>" "g:which_key_map")
    (nvim.command (string.format "%s \" \"" (if visual :WhichKeyVisual :WhichKey)))))
