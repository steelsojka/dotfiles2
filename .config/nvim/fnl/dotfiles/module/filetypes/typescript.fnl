(module dotfiles.module.filetypes.typescript
  {require {keymap dotfiles.keymap
            files dotfiles.files
            headwind dotfiles.headwind}})

(defn compile-project []
  "Compiles a ts project or file"
  (let [buffer-path (vim.fn.expand "%:p:h")
        tsconfig (files.nearest "tsconfig.json" buffer-path)]
    (vim.cmd
      (string.format "Dispatch npxx tsc --noEmit -p %s" tsconfig))))

(fn []
  (keymap.register-buffer-mappings
    {"n mc" {:do #(compile-project) :description "Compile"}})
  (headwind.add-buf-mappings))
