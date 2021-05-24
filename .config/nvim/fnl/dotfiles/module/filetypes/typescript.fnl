(module dotfiles.module.filetypes.typescript
  {require {keymap dotfiles.keymap
            nvim aniseed.nvim
            headwind dotfiles.headwind}})

(fn []
  (set nvim.bo.makeprg (string.format "%s %s $*"
                                      nvim.g.typescript_compiler_binary
                                      nvim.g.typescript_compiler_options))
  (keymap.register-buffer-mappings
    {"n mc" {:do "<Cmd>Make -p tsconfig.json<CR>" :description "Compile"}})
  (headwind.add-buf-mappings))
