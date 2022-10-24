(module dotfiles.lsp.configs
  {require {keymap dotfiles.keymap
            telescope dotfiles.telescope
            files dotfiles.files}})

(local telescope-builtin (require "telescope.builtin"))
(local root-pattern (. (require "lspconfig/util") :root_pattern))
(local lsp-status (require "lsp-status"))

(def configs
 {:tsserver
  #{:root_dir (let [root-fn (root-pattern ".git" "tsconfig.json" "jsconfig.json")]
                (fn [...]
                  (or (root-fn ...) (vim.fn.getcwd))))
    :cmd (let [default-config (. (require "lspconfig.server_configurations.tsserver") :default_config)
               tsserver (files.nearest "node_modules/typescript/lib" (vim.fn.getcwd))
               cmd default-config.cmd]
           (if (and tsserver (not= tsserver ""))
             (let [new_cmd (vim.tbl_extend "force" {} cmd)]
               (vim.list_extend new_cmd ["--tsserver-path" tsserver]))
             cmd))
    :settings
     {:typescript
      {:preferences
       {:importModuleSpecifier "non-relative"
        :quoteStyle "single"}}}}
 ; :lwc {:root_dir (root-pattern "lwc.config.json")}
 :jsonls {}
 :omnisharp
 {:settings
  {:omnisharp
   {:useGlobalMono "always"}}}
 :kotlin_language_server
 {:settings
  {:kotlin
   {:compiler {:jvm {:target "1.8"}}
    :trace {:server "verbose"}}}}
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
     :rootPatterns [".eslintrc.js" ".git"]
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
 :sumneko_lua {:settings
               {:Lua
                {:runtime {:version "LuaJIT" :path (vim.split package.path ";")}
                 :diagnostics {:globals [:vim]}
                 :workspace {:library {(vim.fn.expand "$VIMRUNTIME/lua") true
                                       (vim.fn.expand "$VIMRUNTIME/lua/vim/lsp") true}}}}}})

(def handlers {
  "textDocument/publishDiagnostics" (vim.lsp.with
                                      vim.lsp.diagnostic.on_publish_diagnostics
                                      {:virtual_text false})
  "textDocument/declaration" telescope.location-callback
  "textDocument/definition" telescope.location-callback
  "textDocument/typeDefinition" telescope.location-callback
  "textDocument/implementation" telescope.location-callback})

(defn on-attach [client]
  (lsp-status.on_attach client)
  (when client.server_capabilities.document_highlight
    (keymap.create-autocmds [["CursorHold" "<buffer>" #(vim.lsp.buf.document_highlight)]
                             ["CursorHoldI" "<buffer>" #(vim.lsp.buf.document_highlight)]
                             ["CursorMoved" "<buffer>" #(vim.lsp.buf.clear_references)]]))
  (keymap.register-buffer-mappings
    {"ngd" {:do #(vim.lsp.buf.definition) :silent true}
     "ngy" {:do #(vim.lsp.buf.type_definition) :silent true}
     "ngi" {:do #(vim.lsp.buf.implementation :silent true)}
     "ngr" {:do #(telescope-builtin.lsp_references) :silent true}
     "ngR" {:do "<Cmd>Trouble lsp_references<CR>" :silent true}}))

(defn get-config [overrides]
  (let [cmp-nvim-lsp (require "cmp_nvim_lsp")]
    (vim.tbl_extend "force"
                    {:on_attach on-attach
                     : handlers
                     :capabilities (vim.tbl_extend
                                     "keep"
                                     (cmp-nvim-lsp.default_capabilities
                                       (vim.lsp.protocol.make_client_capabilities))
                                     lsp-status.capabilities)}
                    (or overrides {}))))

(defn get-config-for [name]
  (let [entry (. configs name)
        config (if (= (type entry) "function")
                 (entry)
                 entry)]
    (get-config (or config {}))))

(defn setup []
  (let [server-names (vim.tbl_keys configs)]
    (each [i server-name (ipairs server-names)]
      (let [config (get-config-for server-name)
            lsp-config (require "lspconfig")]
        ((. (. lsp-config server-name) :setup) config)))))
