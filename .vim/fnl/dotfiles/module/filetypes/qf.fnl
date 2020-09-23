(module dotfiles.module.filetypes.qf
  {require {keymap dotfiles.keymap
            qf dotfiles.quickfix
            nvim aniseed.nvim}})

(fn []
  (keymap.register-buffer-mappings
    {"n mn" {:do ":cnewer<CR>" :description "Newer list"}
     "n mp" {:do ":colder<CR>" :description "Older list"}
     "n ml" {:do ":chistory<CR>" :description "List history"}
     "n mF" {:do #(qf.filter true) :description "Filter (destructive)"}
     "n mf" {:do #(qf.filter false) :description "Filter"}
     "n md" {:do #(let [line (. (nvim.fn.getpos ".") 2)]
                    (qf.delete-item line line))
             :description "Delete item"}
     "v md" {:do #(qf.delete-item
                    (. (nvim.fn.getpos "'<") 2)
                    (. (nvim.fn.getpos "'>") 2))
             :description "Delete selected items"}}))
