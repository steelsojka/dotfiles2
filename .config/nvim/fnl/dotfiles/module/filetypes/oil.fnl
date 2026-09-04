(module dotfiles.module.filetypes.oil
  {require {keymap dotfiles.keymap}})

(fn []
  (let [oil (require "oil")]
    (keymap.register-buffer-mappings
      {"mgf" {:do #(-> (oil.get_current_dir)
                               (Snacks.pickers.files))
                      :description "Child file"}
       "mgF" {:do #(-> (vim.fn.getcwd)
                               (Snacks.pickers.files))
                      :description "Project file"}
       "fF" {:do #(-> {:cwd (oil.get_current_dir)}
                              (Snacks.pickers.files))
                     :description "Project file"}}
      {:prefix "<leader>"})))
