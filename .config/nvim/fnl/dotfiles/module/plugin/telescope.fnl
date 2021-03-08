(module dotfiles.module.plugin.telescope
  {require {tele dotfiles.telescope}})

(local telescope (require :telescope))
(local actions (require "telescope.actions"))

(telescope.setup {:defaults
                  {:layout_strategy :flex
                   :mappings {:n {"<leader>q" actions.close}}
                   :winblend 20
                   :width 0.8
                   :prompt_title ""
                   :results_title ""
                   :preview_title ""}
                  :file_previewer (-> (require "telescope.previewers") (. :vim_buffer_cat) (. :new))})

(telescope.load_extension :snippets)
