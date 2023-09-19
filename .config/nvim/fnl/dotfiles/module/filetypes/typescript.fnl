(module dotfiles.module.filetypes.typescript
  {require {keymap dotfiles.keymap
            files dotfiles.files
            utils dotfiles.util}})

(defn compile-project []
  "Compiles a ts project or file"
  (let [buffer-path (vim.fn.expand "%:p:h")
        ts-file-name (utils.get-var "tsconfig_filename" "tsconfig.json")
        tsconfig (files.nearest ts-file-name buffer-path)]
    (vim.cmd
      (string.format "Dispatch npxx tsc --noEmit -p %s" tsconfig))))

(fn []
  (keymap.register-buffer-mappings
    {"mc" {:do #(compile-project) :description "Compile"}}
    {:prefix "<leader>"}))
