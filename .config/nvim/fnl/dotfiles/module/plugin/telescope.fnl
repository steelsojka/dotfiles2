(module dotfiles.module.plugin.telescope
  {require {tele dotfiles.telescope}})

(defn configure []
  (local telescope (require :telescope))
  (local actions (require "telescope.actions"))
  (telescope.setup {:defaults
                    {:layout_strategy :flex
                     :mappings {:n {"<leader>q" actions.close}}
                     :winblend 20
                     :layout_config
                     {:width 0.8}
                     :prompt_title ""
                     :results_title ""
                     :preview_title ""}
                    :file_previewer (-> (require "telescope.previewers") (. :cat) (. :new))}))
