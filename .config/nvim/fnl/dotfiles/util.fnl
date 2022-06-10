(module dotfiles.util
  {require {nvim aniseed.nvim}})

(defn expand [path]
  (nvim.fn.expand path))

(defn glob [path]
  (nvim.fn.glob path true true true))

(defn exists? [path]
  (= (nvim.fn.filereadable path) 1))

(defn lua-file [path]
  (nvim.ex.luafile path))

(def config-path (nvim.fn.stdpath "config"))

(defn nnoremap [from to]
  (nvim.set_keymap
    :n
    (.. "<leader>" from)
    (.. ":" to "<cr>")
    {:noremap true}))

(var id 0)
(defn unique-id [] (set id (+ id 1)) id)
(defn noop [])

(defn exec [prog]
  (var i 0)
  (let [result {}
        pfile (io.popen prog)]
    (each [filename (pfile:lines)]
      (set i (+ i 1))
      (tset result i filename))
    (pfile:close)
    result))

(defn prompt-command [command prompt]
  (let [search-term (nvim.fn.input (string.format "%s: " prompt))]
    (when (> (string.len search-term) 0)
      (nvim.command (string.format "%s %s" command search-term)))))

(defn show-documentation [show-errors]
  (let [cursor (vim.api.nvim_win_get_cursor 0)
        row (. cursor 0)
        help #(nvim.ex.help (nvim.fn.expand "<cword>"))
        diagnostics (vim.lsp.diagnostic.get_line_diagnostics 0 row)]
    (if (or (not show-errors) (= (length diagnostics) 0))
      (if (>= (nvim.fn.index [:vim :lua :help] nvim.bo.filetype) 0)
        (help)
        (let [(success) (pcall #(vim.lsp.buf.hover))]
          (when (not success) (help))))
      (let [(success) (pcall #(vim.diagnostic.open_float))]
        (when (not success) (help))))))

(defn over-all [...]
  (let [fns [...]]
    (fn [...]
      (var result nil)
      (each [_ func (ipairs fns)]
        (set result (func ...)))
      result)))

(defn noop [] "")
