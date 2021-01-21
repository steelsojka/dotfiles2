(module dotfiles.telescope
  {require {utils dotfiles.util}})

(local builtin-actions (require "telescope.actions"))
(local builtin (require "telescope.builtin"))

(defn handle-multi-selection [single-action multi-action prompt]
  (let [picker (builtin-actions.get_current_picker prompt)
        entries (->> picker.multi_select (vim.tbl_keys))
        is-multi (->> entries (length) (< 1))]
    (if is-multi
      (multi-action prompt entries)
      (single-action prompt (. entries 1)))))

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

(fn wrap-file-cmd [cmd]
  (fn [options]
    (cmd (->> {:attach_mappings (utils.flow
                                  mappings.multiselect
                                  mappings.goto-multi-file)}
              (vim.tbl_deep_extend :keep (or options {}))))))

(def find-files (wrap-file-cmd builtin.find_files))
(def live-grep (wrap-file-cmd builtin.live_grep))
(def grep-string (wrap-file-cmd builtin.grep_string))
