(module dotfiles.lsp.configs
  {require {nvim aniseed.nvim
            keymap dotfiles.keymap
            telescope dotfiles.telescope}})

(local lsp (require "lspconfig"))
(local telescope-builtin (require "telescope.builtin"))
(local root-pattern (. (require "lspconfig/util") :root_pattern))
(local home-dir (vim.loop.os_homedir))
(local jdtls-home (.. home-dir "/src/jdt-language-server"))

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
 :angularls {}
 :cssls {}
 :bashls {}
 :gdscript {}
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
 (vim.tbl_extend "force"
                 {:on_attach on-attach
                  : handlers
                  :capabilities (or overrides.capabilities {})}
                 (or overrides {})))
