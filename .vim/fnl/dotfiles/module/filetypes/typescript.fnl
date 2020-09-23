(module dotfiles.module.filetypes.qf
  {require {keymap dotfiles.keymap
            nvim aniseed.nvim}})

(fn []
  (set nvim.bo.makeprg (string.format "%s %s $*"
                                      nvim.g.typescript_compiler_binary
                                      nvim.g.typescript_compiler_options))
  (keymap.register-buffer-mappings
    {"n mc" {:do "<Cmd>Make -p tsconfig.json<CR>" :description "Compile"}}))
