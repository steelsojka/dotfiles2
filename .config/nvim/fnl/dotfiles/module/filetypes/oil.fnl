(module dotfiles.module.filetypes.oil
  {require {keymap dotfiles.keymap}})

(defn- find-files [cwd]
  (let [telescope (require "telescope.builtin")
        pickers (require "telescope.pickers")
        finders (require "telescope.finders")
        actions (require "telescope.actions")
        state (require "telescope.actions.state")
        picker (pickers.new
                {:finder (finders.new_oneshot_job ["fd"
                                                   "--type"
                                                   "directory"
                                                   ".*"
                                                   "--base-directory"
                                                   cwd])
                 :attach_mappings (fn [prompt-bufnr]
                          (let [oil (require "oil")]
                            (actions.select_default:replace
                              #(let [entry (state.get_selected_entry)]
                                 (actions.close prompt-bufnr)
                                 (oil.open (. entry 1)))))
                          true)})]
    (picker:find)))

(fn []
  (let [telescope (require "telescope.builtin")
        oil (require "oil")]
    (keymap.register-buffer-mappings
      {"mgf" {:do #(-> (oil.get_current_dir)
                               (find-files))
                      :description "Child file"}
       "mgF" {:do #(-> (vim.fn.getcwd)
                               (find-files))
                      :description "Project file"}
       "fF" {:do #(-> {:cwd (oil.get_current_dir)}
                              (telescope.find_files))
                     :description "Project file"}}
      {:prefix "<leader>"})))
