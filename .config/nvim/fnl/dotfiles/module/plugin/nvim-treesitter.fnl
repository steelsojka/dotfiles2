(module dotfiles.module.plugin.nvim-treesitter)

(def run ":TSUpdate")

(defn configure []
   (let [parsers (require "nvim-treesitter.parsers")
         configs (require "nvim-treesitter.configs")
         parser_configs (parsers.get_parser_configs)]
      (set parser_configs.http {:install_info
                                {:url "https://github.com/NTBBloodbath/tree-sitter-http"
                                 :revision "main"
                                 :files ["src/parser.c"]}})

      (configs.setup {
         :tree_docs {:enable true
                     :keymaps {:doc_node_at_cursor "<leader>dd"
                               :doc_all_in_range "<leader>dd"}}
         :playground {:enable true
                      :persist_queries true}
         ; :textobjects {:select {:enable false
         ;                        :keymaps {:af "@function.outer"
         ;                                  :if "@function.inner"
         ;                                  :aC "@class.outer"
         ;                                  :iC "@class.inner"
         ;                                  :ac "@conditional.outer"
         ;                                  :ic "@conditional.inner"
         ;                                  :al "@loop.outer"
         ;                                  :il "@loop.inner"
         ;                                  :am "@call.outer"
         ;                                  :im "@call.inner"}}}
         :highlight
         {:enable true
          :disable ["org" "kotlin" "lua"]
          :additional_vim_regex_highlighting ["org"]}
         ; :indent {:enable true}
         ; :refactor {:highlight_definitions {:enable true}}
         :ensure_installed :all
         :ignore_install [:ledger :supercollider :haskell]})))
