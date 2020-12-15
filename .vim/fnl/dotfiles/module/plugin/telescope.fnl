(module dotfiles.module.plugin.telescope)

(local telescope (require :telescope))
(local sorters (require "telescope.sorters"))
(local actions (require "telescope.actions"))

(telescope.setup {:defaults
                  {:layout_strategy :flex
                   :mappings {:n {"<leader>q" actions.close}}}})

(telescope.load_extension :fzy_native)
