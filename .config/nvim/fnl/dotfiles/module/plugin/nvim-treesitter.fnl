(module dotfiles.module.plugin.nvim-treesitter)

(local configs (require "nvim-treesitter.configs"))
(configs.setup {
   :tree_docs {:enable true
               :keymaps {:doc_node_at_cursor "<leader>dd"
                         :doc_all_in_range "<leader>dd"}}
   :playground {:enable true
                :persist_queries true}
   :textobjects {:select {:enable true
                          :keymaps {:af "@function.outer"
                                    :if "@function.inner"
                                    :aC "@class.outer"
                                    :iC "@class.inner"
                                    :ac "@conditional.outer"
                                    :ic "@conditional.inner"
                                    :al "@loop.outer"
                                    :il "@loop.inner"
                                    :am "@call.outer"
                                    :im "@call.inner"}}}
   :highlight {:enable true}
   ; :refactor {:highlight_definitions {:enable true}}
   :ensure_installed :all
   :ignore_install [:ledger :supercollider :haskell]})
