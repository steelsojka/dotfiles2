(module dotfiles.module.filetypes.qf
  {require {keymap dotfiles.keymap
            qf dotfiles.quickfix}})

(fn []
  (keymap.register-buffer-mappings
    {"n mn" {:do ":cnewer<CR>" :description "Newer list"}
     "n mp" {:do ":colder<CR>" :description "Older list"}
     "n ml" {:do ":chistory<CR>" :description "List history"}
     "n md" {:do #(let [line (. (vim.fn.getpos ".") 2)]
                    (qf.delete-item line line))
             :description "Delete item"}
     "v md" {:do #(qf.delete-item
                    (. (vim.fn.getpos "'<") 2)
                    (. (vim.fn.getpos "'>") 2))
             :description "Delete selected items"}}))
