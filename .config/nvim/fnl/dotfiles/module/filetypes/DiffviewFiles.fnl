(module dotfiles.module.filetypes.DiffviewFiles
  {require {keymap dotfiles.keymap}})

(fn []
  (keymap.register-buffer-mappings
    {"<leader>q" {:do "<Cmd>DiffviewClose<CR>" :noremap true :description "Close Diff"}
     "gq" {:do "<Cmd>DiffviewClose<CR>" :noremap true :description "Close Diff"}}))
