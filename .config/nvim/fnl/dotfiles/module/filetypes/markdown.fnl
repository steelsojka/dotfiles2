(module dotfiles.module.filetypes.markdown
  {require {keymap dotfiles.keymap}})

(fn []
  (keymap.register-buffer-mappings
    {"n mp" {:do "<Plug>MarkdownPreview" :noremap false :description "Preview"}}))
