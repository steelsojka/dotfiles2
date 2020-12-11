(module dotfiles.module.plugin.telescope
  {require {nvim aniseed.nvim}})

(local telescope (require :telescope))
(local actions (require "telescope.actions"))

(telescope.setup {:defaults
                  {:layout_strategy :flex
                   :mappings
                   {:n
                    {"<leader>q" actions.close}}}})
