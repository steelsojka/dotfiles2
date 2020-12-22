(module dotfiles.module.plugin.telescope
  {require {tele dotfiles.telescope}})

(local telescope (require :telescope))
(local actions (require "telescope.actions"))

(telescope.setup {:defaults
                  {:layout_strategy :flex
                   :mappings {:n {"<leader>q" actions.close}}}
                  :generic_sorter (. (require "telescope.sorters") :fuzzy_with_index_bias)
                  :file_previewer (-> (require "telescope.previewers") (. :vim_buffer_cat) (. :new))})

