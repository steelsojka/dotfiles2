(module dotfiles.lsp.configs
  {require {nvim aniseed.nvim
            keymap dotfiles.keymap
            lsp-fzf dotfiles.lsp.fzf}})

(local lsp (require "nvim_lsp"))
(local root-pattern (. (require "nvim_lsp/util") :root_pattern))
(local completion (require "completion"))
(local diagnostics (require "diagnostic"))

(def configs
 {:tsserver {:root_dir (root-pattern ".git" "tsconfig.json")
            :settings {:typescript {:preferences {:importModuleSpecifier "non-relative"
                                                  :quoteStyle "single"}}}}
 :jsonls {}
 :html {}
 :vimls {}
 :cssls {}
 :bashls {}
 :jdtls {:init_options {:jvm_args ["-javaagent:/usr/local/share/lombok/lombok.jar"
                                   "-Xbootclasspath/a:/usr/local/share/lombok/lombok.jar"]}}})

(def- callbacks {
  "workspace/symbol" lsp-fzf.symbol-callback
  "textDocument/documentSymbol" lsp-fzf.symbol-callback
  "textDocument/references" lsp-fzf.location-callback
  ; "textDocument/codeAction" lsp-fzf.code-action-callback
  "textDocument/declaration" lsp-fzf.location-callback
  "textDocument/definition" lsp-fzf.location-callback
  "textDocument/typeDefinition" lsp-fzf.location-callback
  "textDocument/implementation" lsp-fzf.location-callback})

(defn on-attach [client]
 (diagnostics.on_attach)
 (when client.resolved_capabilities.document_highlight
   (keymap.create-autocmds [["CursorHold" "<buffer>" #(vim.lsp.buf.document_highlight)]
                            ["CursorHoldI" "<buffer>" #(vim.lsp.buf.document_highlight)]
                            ["CursorMoved" "<buffer>" #(vim.lsp.buf.clear_references)]]))
 (keymap.register-buffer-mappings
   {"ngd" {:do #(vim.lsp.buf.definition) :silent true}
    "ngy" {:do #(vim.lsp.buf.type_definition) :silent true}
    "ngi" {:do #(vim.lsp.buf.implementation :silent true)}
    "ngr" {:do #(vim.lsp.buf.references) :silent true}
    "i<C-Space>" {:do #(vim.lsp.omnifunc) :silent true}}))

(defn get-config [overrides]
 (vim.tbl_extend "force"
                 {:on_attach on-attach
                  : callbacks
                  :capabilities (or overrides.capabilities {})}
                 (or overrides {})))
