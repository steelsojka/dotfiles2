(module dotfiles.diagnostics
  {require {nvim aniseed.nvim
            ansi dotfiles.ansi
            fzf dotfiles.fzf
            core aniseed.core
            lsp-util dotfiles.lsp.util}})

(def- severity vim.lsp.protocol.DiagnosticSeverity)
(def- error-display {severity.Error {:text "Error" :color ansi.red}
                     severity.Warning {:text "Warning" :color ansi.yellow}
                     severity.Information {:text "Info" :color ansi.blue}
                     severity.Hint {:text "Hint" :color #$1}})

(def- _fzf fzf.create
  (fn [_ _ data]
    (lsp-util.handle-location-items
      data
      #(lsp-util.uri-to-location $1.uri $1.range.start.line $1.range.start.character))))

(defn- format-diagnostics [items]
  (-> (fzf.create-grid [{:heading "Message" :length 60 :map ansi.red :truncate true}
                        {:heading "Severity" :length 15 :map ansi.red}
                        {:heading "Loc" :length 12 :map ansi.red}
                        {:heading "File" :map ansi.red}]
                       (core.map #(let [err-display (. error-display $1.severity)]
                                    [{:value $1.message}
                                     {:value err-display.text :map err-display.color}
                                     {:value (.. $1.range.start.line ":" $1.range.start.character) :map ansi.blue}
                                     {:value (or $1.uri "N/A") :map ansi.cyan}
                                     (tostring $2)]) items))
      (fzf.grid-to-source)))

(defn- get-diagnostics [options]
  (let [{: bufnr : filetype} (or options {})]
    (if bufnr
      (or (. vim.lsp.util.diagnostics_by_buf bufnr) {})
      (do
        (var result [])
        (each [_ diagnostics (pairs vim.lsp.util.diagnostics_by_buf)]
          (set result
               (->> (if filetype
                      (core.filter #(= $1.source filetype) diagnostics)
                      diagnostics)
                    (table.concat result))))
        result))))

(defn open-diagnostics [options]
  (let [{: bufnr} (or options {})
        diagnostics (get-diagnostics options)
        source (format-diagnostics diagnostics bufnr)]
    (_fzf.execute {:options ["--ansi" "--multi" "--header-lines=1"]
                   : source
                   :window (win.float-window)
                   :data diagnostics})))
