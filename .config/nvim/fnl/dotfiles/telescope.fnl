(module dotfiles.telescope
  {require {utils dotfiles.util
            buffers dotfiles.buffers
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
   :delete-buffers (fn [_ map]
                     (map :n "<Cr>" actions.delete-buffers)
                     (map :i "<Cr>" actions.delete-buffers)
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
                :attach_mappings (utils.flow mappings.multiselect mappings.goto-multi-file)
                :finder (finders.new_table
                          {:results items
                           :entry_maker (make-entry.gen_from_quickfix options)})})
               (: :find)))
        (vim.lsp.util.jump_to_location (. result 1)))
      (vim.lsp.util.jump_to_location result))))

(defn delete-buffers []
  (let [bufs (buffers.get-listed-buffers)
        options {}
        displayer (entry-display.create {:separator " "
                                         :items [{} {} {}]})]
    (-> (pickers.new
         {:prompt_title "Kill Buffers"
          :finder (finders.new_table
                    {:results bufs
                     :entry_maker (fn [bufnr]
                                    {:display (displayer (buffers.format-buf-entry bufnr))
                                     :value bufnr
                                     :ordinal 1})})
          :sorter (telescope-conf.generic_sorter options)
          :attach_mappings (utils.flow
                             mappings.multiselect
                             mappings.delete-buffers)})
        (: :find))))

(fn wrap-file-cmd [cmd]
  (fn [options]
    (cmd (->> {:attach_mappings (utils.flow mappings.multiselect mappings.goto-multi-file)}
              (vim.tbl_deep_extend :keep (or options {}))))))

(def find-files (wrap-file-cmd builtin.find_files))
(def live-grep (wrap-file-cmd builtin.live_grep))
(def grep-string (wrap-file-cmd builtin.grep_string))
