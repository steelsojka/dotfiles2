(module dotfiles.module.plugin.jdtls)

(local finders (require "telescope.finders"))
(local sorters (require "telescope.sorters"))
(local actions (require "telescope.actions"))
(local pickers (require "telescope.pickers"))

(fn pick-one [items prompt label-fn callback]
  (let [opts {}]
    (-> (pickers.new
          opts
          {:prompt_title prompt
           :finder (finders.new_table
                     {:results items
                      :entry_maker #{:value $1
                                     :display (label-fn $1)
                                     :ordinal (label-fn $1)}})
           :sorter (sorters.get_generic_fuzzy_sorter)
           :attach_mappings (fn [bufnr]
                              (actions.goto_file_selection_edit:replace
                                (fn []
                                  (let [selection (actions.get_selected_entry bufnr)]
                                    (actions.close bufnr)
                                    (callback selection.value))))
                              true)})
        (: :find))))

(defn configure []
  (let [jdtls-ui (require "jdtls.ui")]
    (set jdtls-ui.pick_one_async pick-one)))
