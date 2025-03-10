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
          :additional_vim_regex_highlighting ["org"]}
         ; :indent {:enable true}
         ; :refactor {:highlight_definitions {:enable true}}
         :ensure_installed
         [
          "apex"
          "awk"
          "bash"
          "c"
          "c_sharp"
          "clojure"
          "cmake"
          "cpp"
          "css"
          "diff"
          "fennel"
          "gdscript"
          "git_config"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
          "graphql"
          "groovy"
          "http"
          "java"
          "javascript"
          "jsonc"
          "json"
          "json5"
          "lua"
          "luadoc"
          "org"
          "pug"
          "python"
          "properties"
          "scheme"
          "sql"
          "ssh_config"
          "todotxt"
          "toml"
          "typescript"
          "vim"
          "vimdoc"
          "xml"
         ]})))
