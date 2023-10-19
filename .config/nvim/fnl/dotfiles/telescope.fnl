(module dotfiles.telescope
  {require {utils dotfiles.util
            buffers dotfiles.buffers
            files dotfiles.files
            lib dotfiles.lib
            nvim aniseed.nvim}})

(defn handle-multi-selection [single-action multi-action prompt]
  (let [picker (lib.telescope_actions_state.get_current_picker prompt)
        entries (picker:get_multi_selection)
        is-multi (->> entries (length) (< 1))]
    (if is-multi
      (multi-action prompt entries)
      (single-action prompt (picker:get_selection)))))

(fn to-qf-items [entries]
  (let [result []]
    (each [_ entry (pairs entries)]
      (table.insert result {:filename (or entry.filename (. entry 1))
                            :lnum (or entry.lnum 1)
                            :col (or entry.col 1)
                            :text (or entry.text (. entry 1))}))
    result))

(def actions (->>
  {:select-multi-item (fn [prompt]
                        (let [picker (lib.telescope_actions_state.get_current_picker prompt)
                              row (picker:get_selection_row)
                              index (picker:get_index row)
                              entry (picker.manager:get_entry index)
                              is-selected (or (picker:is_multi_selected entry) false)]
                          (if is-selected
                            (picker:remove_selection row)
                            (picker:add_selection row))
                          (lib.telescope_actions.prompt)))
   :delete-buffers (fn [prompt cmd]
                    (handle-multi-selection
                      #(nvim.ex.bw $2.value)
                      #(each [_ entry (ipairs $2)] (nvim.ex.bw entry.value))
                      prompt)
                    (lib.telescope_actions.close prompt))
   :paste-entry (fn [prompt]
                  (let [entry (lib.telescope_actions_state.get_selected_entry prompt)]
                    (lib.telescope_actions.close prompt)
                    (vim.api.nvim_put [entry.value] "" true true)))
   :print (fn [prompt]
            (let [entry (lib.telescope_actions_state.get_selected_entry prompt)]
              (print (vim.inspect entry))))
   :goto-file (fn [prompt cmd]
                (handle-multi-selection
                  #(lib.telescope_actions_set.edit prompt cmd)
                  (fn [_ entries]
                    (vim.fn.setqflist (to-qf-items entries))
                    (vim.cmd :copen)
                    (vim.cmd :cc))
                  prompt))})
  ((. (require "telescope.actions.mt") :transform_mod)))

(def mappings
  {:multiselect (fn [_ map]
                  (map :n "<Tab>" actions.select-multi-item)
                  (map :i "<Tab>" actions.select-multi-item)
                  true)
   :kill-buffers (fn [_ map]
                     (map :n "<C-k>" actions.delete-buffers)
                     (map :i "<C-k>" actions.delete-buffers)
                     true)
   :paste-entry (fn [_ map]
                    (map :n "<CR>" actions.paste-entry)
                    (map :i "<CR>" actions.paste-entry)
                    true)
   :print (fn [_ map]
              (map :n "<CR>" actions.print)
              (map :i "<CR>" actions.print)
              true)
   :goto-multi-file (fn [prompt map]
                      (map :n "<Cr>" #(do (actions.goto-file prompt :edit) (lib.telescope_actions.center $...)))
                      (map :i "<Cr>" #(do (actions.goto-file prompt :edit) (lib.telescope_actions.center $...)))
                      (map :n "<C-x>" (partial actions.goto-file prompt :new))
                      (map :i "<C-x>" (partial actions.goto-file prompt :new))
                      (map :n "<C-v>" (partial actions.goto-file prompt :vnew))
                      (map :i "<C-v>" (partial actions.goto-file prompt :vnew))
                      (map :n "<C-t>" (partial actions.goto-file prompt :tabedit))
                      (map :i "<C-t>" (partial actions.goto-file prompt :tabedit))
                      true)})

(defn location-callback [_ result _ _]
  (when (and result (not (vim.tbl_isempty result)))
    (if (vim.tbl_islist result)
      (if (> (length result) 1)
        (let [items (vim.lsp.util.locations_to_items result)
              options {:shorten_path true}
              make_entry (require "telescope.make_entry")]
          (-> (lib.telescope_pickers.new
               options
               {:prompt_title "LSP Location"
                :previewer (lib.telescope_config.values.qflist_previewer options)
                :sorter (lib.telescope_config.values.generic_sorter options)
                :attach_mappings (utils.over-all mappings.multiselect mappings.goto-multi-file)
                :finder (lib.telescope_finders.new_table
                          {:results items
                           :entry_maker (make_entry.gen_from_quickfix options)})})
               (: :find)))
        (vim.lsp.util.jump_to_location (. result 1)))
      (vim.lsp.util.jump_to_location result))))

(defn buffers []
  "Buffers with multi select and kill buffer mappings"
  (lib.telescope_builtin.buffers
    {:attach_mappings (utils.over-all
                        mappings.multiselect
                        mappings.kill-buffers)}))

(fn make-paste-relative-path-action [from-path]
  (fn [prompt]
    (let [picker (lib.telescope_actions_state.get_current_picker prompt)
          selection (picker:get_selection)
          path (if selection (files.to-relative-path from-path selection.value) "")]
      (var result path)
      (lib.telescope_actions.close prompt)
      (when (and result (not= result ""))
        (when (~= (result:sub 1 1) ".")
          (set result (.. "./" result)))
        (vim.api.nvim_put [result] "" true true)))))

(fn make-completion-action [opts]
  (fn [prompt]
    (let [picker (lib.telescope_actions_state.get_current_picker prompt)
          selection (picker:get_selection)
          line (- opts.line 1)
          current-line (or
                         (. (vim.api.nvim_buf_get_lines opts.bufnr line (+ line 1) false) 1)
                         "")
          content (.. (string.sub current-line 1 (- opts.start-col 1))
                      selection.value
                      (string.sub current-line (+ opts.end-col 1)))]
      (lib.telescope_actions.close prompt)
      (vim.api.nvim_buf_set_lines opts.bufnr
                                  line
                                  (+ line 1)
                                  false
                                  [content]))))

(defn insert-relative-path [from-path default-text]
  "Searches for a file in the project and inserts the relative path from the path provided.
  Requires node to be installed (which it will always be... let's be real)."
  (-> (lib.telescope_pickers.new {:prompt_title "Insert Relative Path"
                    :finder (lib.telescope_finders.new_oneshot_job ["rg" "--files"])
                    :default_text (or default-text "")
                    :sorter (telescope-conf.generic_sorter)
                    :attach_mappings (fn [prompt map]
                                       (map :n "<CR>" (make-paste-relative-path-action from-path))
                                       (map :i "<CR>" (make-paste-relative-path-action from-path))
                                       true)})
      (: :find)))

(defn insert-word []
  "Inserts a word from a dictionary"
  (-> (lib.telescope_pickers.new {:prompt_title "Insert Word"
                    :finder (lib.telescope_finders.new_oneshot_job ["cat" vim.o.dictionary])
                    :sorter (telescope-conf.generic_sorter)
                    :attach_mappings mappings.paste-entry})
      (: :find)))

(defn complete-path [_bufnr]
  (let [bufnr (or _bufnr (vim.api.nvim_get_current_buf))
        win (vim.api.nvim_get_current_win)
        cursor (vim.api.nvim_win_get_cursor win)
        line (. cursor 1)
        col (if (= (. (vim.api.nvim_get_mode) :mode) :n)
              (+ (. cursor 2) 1)
              (. cursor 2))
        lines (vim.api.nvim_buf_get_lines bufnr (- line 1) col false)
        content (or (. lines 1) "")
        content-to-cursor (string.sub content 1 col)
        opts (vim.tbl_extend :keep (files.get-fname-prefix content-to-cursor) {: line : bufnr : win})
        picker (lib.telescope_pickers.new
                 {:prompt_title "Complete Path"
                  :finder (lib.telescope_finders.new_oneshot_job ["rg" "--files"])
                  :sorter (telescope-conf.generic_sorter)
                  :attach_mappings (fn [_ map]
                                     (map :n "<CR>" (make-completion-action opts))
                                     (map :i "<CR>" (make-completion-action opts))
                                     true)})]
    (picker:find)
    (vim.api.nvim_feedkeys opts.prefix :m false)))

(fn wrap-file-cmd [cmd]
  (fn [options]
    (cmd (->> {:attach_mappings (utils.over-all mappings.multiselect mappings.goto-multi-file)}
              (vim.tbl_deep_extend :keep (or options {}))))))

(def find-files (wrap-file-cmd (fn [...] (lib.telescope_builtin.find_files ...))))
(def live-grep (wrap-file-cmd (fn [...] (lib.telescope_builtin.live_grep ...))))
(def grep-string (wrap-file-cmd (fn [...] (lib.telescope_builtin.grep_string ...))))
