(module dotfiles.quickfix
  {require {nvim aniseed.nvim
            core aniseed.core
            ansi dotfiles.ansi
            win dotfiles.window
            fzf dotfiles.fzf}})

(defn replace-list [list options?]
  (let [options (or options? {})
        nr (or options.win 0)]
    (if options.loc
        (vim.fn.setloclist nr [] "r" {:items list})
        (vim.fn.setqflist [] "r" {:items list}))))

(defn delete-item [start-line end-line options?]
  (let [options (or options? {})
        nr (or options.win 0)
        qf-list (if options.loc
                  (vim.fn.getloclist nr)
                  (vim.fn.getqflist))]
    (var i start-line)
    (while (<= i end-line)
      (table.remove qf-list start-line)
      (set i (+ i 1)))
    (replace-list qf-list options)))

(defn add-item [start-line end-line options?]
  (let [options (or options? {})
        nr (or options.win 0)
        qf-list (if options.loc
                  (vim.fn.getloclist nr)
                  (vim.fn.getqflist))
        buf (nvim.get_current_buf)
        lines (nvim.buf_get_lines buf start-line end-line false)
        new-list (core.map-indexed
                   #(let [[i v] $1]
                      {:bufnr buf
                       :lnum (+ start-line i)
                       :col 0
                       :text v})
                   lines)
        updated-list (vim.list_extend qf-list new-list)]
    (replace-list updated-list options)))

(defn new-list [title]
  (nvim.fn.setqflist [] " " {:title (or title "")})
  (nvim.ex.copen))
