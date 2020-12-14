(module dotfiles.module.plugin.telescope)

(local telescope (require :telescope))
(local sorters (require "telescope.sorters"))
(local actions (require "telescope.actions"))

(telescope.setup {:defaults
                  {:layout_strategy :flex
                   :mappings {:n {"<leader>q" actions.close}}
                   :file_sorter sorters.get_fzy_sorter
                   :generic_sorter sorters.get_fzy_sorter}})
