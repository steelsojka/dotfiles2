(module dotfiles.quickfix
  {require {nvim aniseed.nvim
            core aniseed.core
            ansi dotfiles.ansi
            win dotfiles.window
            fzf dotfiles.fzf}})

(defn build-list [lines]
  (nvim.fn.setqflist (core.map #{:filename $1}))
  (nvim.ex.copen)
  (nvim.ex.cc))

(defn to-fzf-list []
  (fzf.grid-to-source
    (fzf.create-grid
      [{:heading "Text" :length 45 :map ansi.red}
       {:heading "Loc" :length 12 :map ansi.red}
       {:heading "File" :map ansi.red}]
      (core.map-indexed
        #(let [[i v] $1]
           [$1.text
            {:value (.. v.lnum ":" v.col) :map ansi.blue}
            {:value (nvim.buf_get_name v.bufnr) :map ansi.cyan}
            (tostring i) ])
        (nvim.fn.getqflist)))))

(defn filter [destructive]
  (local _fzf
    (fzf.create #(if (not destructive)
                   (nvim.fn.setqflist $3)
                   (nvim.fn.setqflist [] "r" {:items $3}))
                {:handle-all true
                 :indexed-data true}))
  (_fzf.execute {:source (get-fzf-list)
                 :window (win.float-window #(_fzf.unsubscribe))
                 :options ["--multi" "--ansi" "--header-lines=1"]
                 :data (nvim.fn.getqflist)}))

(defn delete-item [start-line end-line]
  (let [qf-list (nvim.fn.getqflist)]
    (var i start-line)
    (while (<= i end-line)
      (table.remove qf-list start-line)
      (set i (+ i 1)))
    (nvim.fn.setqflist [] "r" {:items qf-list})))

(defn add-item [start-line end-line]
  (let [qf-list (nvim.fn.getqflist)
        buf (nvim.get_current_buf)
        lines (nvim.buf_get_lines buf start-line end-line false)
        new-list (core.map-indexed
                   #(let [[i v] $1]
                      {:bufnr buf
                       :lnum (- (+ start-line i) 1)
                       :col 0
                       :text v})
                   lines)]
    (nvim.fn.setqflist [(unpack qf-list) (unpack new-list)])))

(defn new-list [title]
  (nvim.fn.setqflist [] " " {:title (or title "")})
  (nvim.ex.copen))
