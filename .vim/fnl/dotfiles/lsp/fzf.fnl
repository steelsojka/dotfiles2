(module dotfiles.lsp.fzf
  {require {nvim aniseed.nvim
            core aniseed.core
            fzf dotfiles.fzf
            ansi dotfiles.ansi
            win dotfiles.window
            lsp-util dotfiles.lsp.util}})

(def- fzf-loc-handler
  (fzf.create
    (fn [_ _ data]
      (core.map
        #(lsp-util.file-to-location $1.filename (- $1.lnum 1) (- $1.col 1)) data))
    {:handle-all true :indexed-data true}))

(def- fzf-code-action-handler
  (fzf.create
    (fn [_ _ actions]
      (each [_ action (ipairs actions)]
        (if (or action.edit (= (type action.command) :table))
          (do
            (when action.edit
              (vim.lsp.util.apply_workspace_edit action.edit))
            (when (= (type action.command) :table)
              (vim.lsp.buf.execute_command action.command)))
          (vim.lsp.buf.execute_command action))))
    {:handle-all true :indexed-data true}))

(defn location-callback [_ _ result _ _]
  (when (and result (not (vim.tbl_isempty result)))
    (if (vim.tbl_islist result)
      (if (> (length result) 1)
        (let [items (vim.lsp.util.loctions_to_items result)
              grid (fzf.create-grid
                     [{:heading "Text" :length 60 :map ansi.red :truncate true}
                      {:heading "Loc" :length 12 :map ansi.red}
                      {:heading "File" :map ansi.red}]
                     (core.map-indexed
                       #(let [[i v] $1]
                          [(vim.trim v.text)
                           {:value (.. v.lnum ":" v.col) :map ansi.blue}
                           {:value v.filename :map ansi.cyan}
                           (tostring i)])
                       items))]
          (fzf-loc-handler.execute
            {:options ["--multi" "--ansi" "--header-lines=1"]
             :source (fzf.grid-to-source grid)
             :window (win.float-window)
             :data items}))
        (vim.lsp.util.jump_to_location (. result 1)))
      (vim.lsp.util.jump_to_location result))))

(defn symbol-callback [_ _ result _ _]
  (when (and result (not (vim.tbl_isempty result)))
    (let [items (vim.lsp.util.symbols_to_items result)
          grid (fzf.create-grid
                 [{:heading "Symbol" :length 35 :map ansi.red :truncate true}
                  {:heading "Loc" :length 12 :map ansi.red}
                  {:heading "Kind" :length 15 :map ansi.red}
                  {:heading "File" :map ansi.red}]
                 (core.map-indexed
                   #(let [[i v] $1
                          symbol (string.match v.text "] (.*)")]
                      [symbol
                       {:value (.. v.lnum ":" v.col) :map ansi.blue}
                       {:value v.kind :map ansi.yellow}
                       {:value v.filename :map ansi.cyan}
                       (tostring i)])))]
      (fzf-loc-handler.execute
            {:options ["--multi" "--ansi" "--with-nth=1..4" "-n" "1,3,4" "--header-lines=1"]
             :source (fzf.grid-to-source grid)
             :window (win.float-window)
             :data items}))))

(defn code-action-callback [_ _ actions _ _]
  (if (or (not actions) (vim.tbl_isempty actions))
    (print "No code actions available")
    (let [grid (fzf.create-grid
                 [{:heading "Title" :map ansi.red}]
                 (core.map-indexed #(let [[i v] $1] [v.title (tostring i)] actions)))]
      (fzf-code-action-handler.execute
        {:options ["--ansi" "--header-lines=1"]
         :source (fzf.grid-to-source grid)
         :window (win.float-window)
         :data actions}))))
