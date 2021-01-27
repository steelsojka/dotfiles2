(module dotfiles.telescope
  {require {utils dotfiles.util
            buffers dotfiles.buffers
            files dotfiles.files
            nvim aniseed.nvim}})

(local builtin-actions (require "telescope.actions"))
(local builtin (require "telescope.builtin"))
(local pickers (require "telescope.pickers"))
(local entry-display (require "telescope.pickers.entry_display"))
(local finders (require "telescope.finders"))
(local make-entry (require "telescope.make_entry"))
(local telescope-conf (. (require "telescope.config") :values))

(defn handle-multi-selection [single-action multi-action prompt]
  (let [picker (builtin-actions.get_current_picker prompt)
        entries (->> picker.multi_select (vim.tbl_keys))
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
                        (let [picker (builtin-actions.get_current_picker prompt)
                              row (picker:get_selection_row)
                              index (picker:get_index row)
                              entry (picker.manager:get_entry index)
                              is-selected (or (. picker.multi_select entry) false)]
                          (tset picker.multi_select entry (if is-selected nil true))
                          (builtin-actions.move_selection_next prompt)))
   :delete-buffers (fn [prompt cmd]
                    (handle-multi-selection
                      #(nvim.ex.bw $2.value)
                      #(each [_ entry (ipairs $2)] (nvim.ex.bw entry.value))
                      prompt)
                    (builtin-actions.close prompt))
   :paste-entry (fn [prompt]
                  (let [entry (builtin-actions.get_selected_entry prompt)]
                    (builtin-actions.close prompt)
                    (vim.api.nvim_put [entry.value] "" true true)))
   :print (fn [prompt]
            (let [entry (builtin-actions.get_selected_entry prompt)]
              (print (vim.inspect entry))))
   :goto-file (fn [prompt cmd]
                (handle-multi-selection
                  #(builtin-actions._goto_file_selection prompt cmd)
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
                      (map :n "<Cr>" #(do (actions.goto-file prompt :edit) (builtin-actions.center $...)))
                      (map :i "<Cr>" #(do (actions.goto-file prompt :edit) (builtin-actions.center $...)))
                      (map :n "<C-x>" (partial actions.goto-file prompt :new))
                      (map :i "<C-x>" (partial actions.goto-file prompt :new))
                      (map :n "<C-v>" (partial actions.goto-file prompt :vnew))
                      (map :i "<C-v>" (partial actions.goto-file prompt :vnew))
                      (map :n "<C-t>" (partial actions.goto-file prompt :tabedit))
                      (map :i "<C-t>" (partial actions.goto-file prompt :tabedit))
                      true)})

(defn location-callback [_ _ result _ _]
  (when (and result (not (vim.tbl_isempty result)))
    (if (vim.tbl_islist result)
      (if (> (length result) 1)
        (let [items (vim.lsp.util.locations_to_items result)
              options {:shorten_path true}]
          (-> (pickers.new
               options
               {:prompt_title "LSP Location"
                :previewer (telescope-conf.qflist_previewer options)
                :sorter (telescope-conf.generic_sorter options)
                :attach_mappings (utils.over-all mappings.multiselect mappings.goto-multi-file)
                :finder (finders.new_table
                          {:results items
                           :entry_maker (make-entry.gen_from_quickfix options)})})
               (: :find)))
        (vim.lsp.util.jump_to_location (. result 1)))
      (vim.lsp.util.jump_to_location result))))

(defn buffers []
  "Buffers with multi select and kill buffer mappings"
  (builtin.buffers
    {:attach_mappings (utils.over-all
                        mappings.multiselect
                        mappings.kill-buffers)}))

(fn make-paste-relative-path-action [from-path]
  (fn [prompt]
    (let [picker (builtin-actions.get_current_picker prompt)
          selection (picker:get_selection)
          path (if selection (files.to-relative-path from-path selection.value) "")]
      (var result path)
      (builtin-actions.close prompt)
      (when (and result (not= result ""))
        (when (~= (result:sub 1 1) ".")
          (set result (.. "./" result)))
        (vim.api.nvim_put [result] "" true true)))))

(fn make-completion-action [opts]
  (fn [prompt]
    (let [picker (builtin-actions.get_current_picker prompt)
          selection (picker:get_selection)
          line (- opts.line 1)
          current-line (or
                         (. (vim.api.nvim_buf_get_lines opts.bufnr line (+ line 1) false) 1)
                         "")
          content (.. (string.sub current-line 1 (- opts.start-col 1))
                      selection.value
                      (string.sub current-line (+ opts.end-col 1)))]
      (builtin-actions.close prompt)
      (vim.api.nvim_buf_set_lines opts.bufnr
                                  line
                                  (+ line 1)
                                  false
                                  [content]))))

(defn insert-relative-path [from-path default-text]
  "Searches for a file in the project and inserts the relative path from the path provided.
  Requires node to be installed (which it will always be... let's be real)."
  (-> (pickers.new {:prompt_title "Insert Relative Path"
                    :finder (finders.new_oneshot_job ["rg" "--files"])
                    :default_text (or default-text "")
                    :sorter (telescope-conf.generic_sorter)
                    :attach_mappings (fn [prompt map]
                                       (map :n "<CR>" (make-paste-relative-path-action from-path))
                                       (map :i "<CR>" (make-paste-relative-path-action from-path))
                                       true)})
      (: :find)))

(defn insert-word []
  "Inserts a word from a dictionary"
  (-> (pickers.new {:prompt_title "Insert Word"
                    :finder (finders.new_oneshot_job ["cat" vim.o.dictionary])
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
        picker (pickers.new
                 {:prompt_title "Complete Path"
                  :finder (finders.new_oneshot_job ["rg" "--files"])
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

(def find-files (wrap-file-cmd builtin.find_files))
(def live-grep (wrap-file-cmd builtin.live_grep))
(def grep-string (wrap-file-cmd builtin.grep_string))
