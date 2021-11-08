(module dotfiles.lsp.configs
  {require {nvim aniseed.nvim
            keymap dotfiles.keymap
            telescope dotfiles.telescope}})

(local lsp (require "lspconfig"))
(local lsp-configs (require "lspconfig/configs"))
(local telescope-builtin (require "telescope.builtin"))
(local root-pattern (. (require "lspconfig/util") :root_pattern))
(local home-dir (vim.loop.os_homedir))
(local jdtls-home (.. home-dir "/src/jdt-language-server"))

(set lsp-configs.tailwindcss
     {:default_config
      {:cmd ["node" (.. home-dir "/src/tailwindcss-intellisense/dist/server/tailwindServer.js") "--stdio"]
       :filetypes ["html" "typescriptreact" "javascriptreact" "tsx" "jsx"]
       :root_dir (root-pattern ".git")
       ; :handlers
       ; {"tailwindcss/getConfiguration" (fn [err _ params client-id bufnr]
       ;                                   (let [client (vim.lsp.get_client_by_id client-id)]
       ;                                     (when client
       ;                                       (let [configuration (or (vim.lsp.util.lookup_section clien.config.settings "tailwindCSS")
       ;                                                               {})]
       ;                                         (set configuration._id params._id)
       ;                                         (set configuration.tabSize (vim.lsp.util.get_effective_tabstop bufnr))
       ;                                         (vim.lsp.buf_notify bufnr "tailwindcss/getConfigurationResponse" configuration)))))}
       }})

(def configs
 {:tsserver
  {:root_dir (root-pattern ".git" "tsconfig.json")
   :settings
    {:typescript
     {:preferences
      {:importModuleSpecifier "non-relative"
       :quoteStyle "single"}}}}
 :jsonls {}
 :clojure_lsp {}
 :html {}
 :vimls {}
 ; :angularls {}
 ; :omnisharp
 ; {:cmd ["omnisharp" "--languageserver" "--hostPID" (tostring (vim.fn.getpid))]
 ;  :root_dir (root-pattern ".git")}
 :cssls {}
 :bashls {}
 :gdscript {}
 :yamlls {}
 :kotlin_language_server
 {:root_dir (root-pattern ".git")
  :settings
  {:kotlin {:compiler {:jvm {:target "1.8"}}}}}
 :tailwindcss {}
 :diagnosticls
 {:filetypes ["javascript"
              "javascriptreact"
              "javascript.jsx"
              "typescript"
              "typescriptreact"
              "typescript.tsx"]
  :root_dir (root-pattern ".git")
  :init_options
  {:linters
   {:eslint
    {:command "npxx"
     :rootPatterns [".git"]
     :debounce 100
     :args ["eslint"
            "--stdin"
            "--stdin-filename"
            "%filepath"
            "--format"
            "json"]
     :sourceName :eslint
     :parseJson {:errorsRoot "[0].messages"
                 :line :line
                 :column :column
                 :endLine :endLine
                 :endColumn :endColumn
                 :message "${message} [${ruleId}]"
                 :security :severity}
     :securities {"2" :error
                  "1" :warning}}}
   :filetypes
   {"javascript" "eslint"
    "typescript" "eslint"
    "typescript.jsx" "eslint"
    "javascript.jsx" "eslint"
    "javascriptreact" "eslint"
    "typescriptreact" "eslint"}}}
 :sumneko_lua (let [system-name (if
                                  (= (vim.fn.has :mac) 1) :macOS
                                  (= (vim.fn.has :unix) 1) :Linux
                                  (= (vim.fn.has :win32) 1) :Windows
                                  "")
                    root-path (.. home-dir "/src/lua-language-server")
                    binary (.. root-path "/bin/" system-name "/lua-language-server")]
                {:cmd [binary "-E" (.. root-path "/main.lua")]
                 :settings
                 {:Lua
                  {:runtime {:version "LuaJIT" :path (vim.split package.path ";")}
                   :diagnostics {:globals [:vim]}
                   :workspace {:library {(vim.fn.expand "$VIMRUNTIME/lua") true
                                         (vim.fn.expand "$VIMRUNTIME/lua/vim/lsp") true}}}}})})

(def handlers {
  "textDocument/publishDiagnostics" (vim.lsp.with
                                      vim.lsp.diagnostic.on_publish_diagnostics
                                      {:virtual_text false})
  "textDocument/declaration" telescope.location-callback
  "textDocument/definition" telescope.location-callback
  "textDocument/typeDefinition" telescope.location-callback
  "textDocument/implementation" telescope.location-callback})

(defn on-attach [client]
 (when client.resolved_capabilities.document_highlight
   (keymap.create-autocmds [["CursorHold" "<buffer>" #(vim.lsp.buf.document_highlight)]
                            ["CursorHoldI" "<buffer>" #(vim.lsp.buf.document_highlight)]
                            ["CursorMoved" "<buffer>" #(vim.lsp.buf.clear_references)]]))
 (keymap.register-buffer-mappings
   {"ngd" {:do #(vim.lsp.buf.definition) :silent true}
    "ngy" {:do #(vim.lsp.buf.type_definition) :silent true}
    "ngi" {:do #(vim.lsp.buf.implementation :silent true)}
    "ngr" {:do #(telescope-builtin.lsp_references) :silent true}}))

(defn get-config [overrides]
 (let [cmp-nvim-lsp (require "cmp_nvim_lsp")]
   (vim.tbl_extend "force"
                   {:on_attach on-attach
                    : handlers
                    :capabilities (cmp-nvim-lsp.update_capabilities
                                    (vim.lsp.protocol.make_client_capabilities))}
                   (or overrides {}))))
