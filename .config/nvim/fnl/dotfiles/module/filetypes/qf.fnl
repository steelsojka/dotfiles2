(module dotfiles.module.filetypes.qf
  {require {keymap dotfiles.keymap
            qf dotfiles.quickfix}})

(fn []
  (keymap.register-buffer-mappings
    {"md" {:do #(qf.delete-item
                    (. (vim.fn.getpos "'<") 2)
                    (. (vim.fn.getpos "'>") 2))
             :description "Delete selected items"}}
    {:prefix "<leader>" :mode "v"})
  (keymap.register-buffer-mappings
    {"mn" {:do ":cnewer<CR>" :description "Newer list"}
     "mp" {:do ":colder<CR>" :description "Older list"}
     "ml" {:do ":chistory<CR>" :description "List history"}
     "md" {:do #(let [line (. (vim.fn.getpos ".") 2)]
                    (qf.delete-item line line))
             :description "Delete item"}}
    {:prefix "<leader>"}))
