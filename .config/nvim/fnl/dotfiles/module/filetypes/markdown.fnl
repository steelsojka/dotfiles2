(module dotfiles.module.filetypes.markdown
  {require {keymap dotfiles.keymap}})

(fn []
  (keymap.register-buffer-mappings
    {"mp" {:do "<Plug>MarkdownPreview" :noremap false :description "Preview"}}
    {:prefix "<leader>"}))
