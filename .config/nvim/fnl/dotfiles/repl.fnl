(module dotfiles.repl
  {require {buffers dotfiles.buffers
            terminal dotfiles.terminal}})

(local repls
  {:javascript {:cmd #(let [cwd (vim.fn.getcwd)]
                        (string.format "NODE_PATH=%q node" cwd))}
   :typescript {:cmd #(let [cwd (vim.fn.getcwd)]
                        (string.format "ts-node --dir %q" cwd))}})

(local active-repls {})

(defn get-repl [bufnr?]
  (let [bufnr (or bufnr? (vim.api.nvim_get_current_buf))]
    (. active-repls bufnr)))

(defn create-repl [bufnr cmd]
  (let [[new-bufnr] (terminal.new-term-buf cmd)]
    (tset active-repls bufnr new-bufnr)
    new-bufnr))

(defn open-repl [bufnr? ft?]
  (let [bufnr (or bufnr? (vim.api.nvim_get_current_buf))
        existing-repl (get-repl bufnr)
        ft (or ft? (vim.api.nvim_buf_get_option bufnr "filetype"))
        repl-def (. repls ft)
        current-window (vim.api.nvim_get_current_win)]
    (var repl-bufnr existing-repl)
    (if (not repl-def)
      (print (.. "No REPL definition for " ft))
      (do
        (when (not existing-repl)
          (set repl-bufnr (create-repl bufnr (repl-def.cmd))))
        (when (not (buffers.is-buf-visible repl-bufnr))
          (vim.cmd "vsplit")
          (vim.cmd (string.format "buffer %d" repl-bufnr))
          (let [jobid (vim.api.nvim_buf_get_option repl-bufnr "channel")]
            (vim.api.nvim_buf_set_var bufnr "slime_config" {: jobid})
            (vim.api.nvim_set_current_win current-window)))))))

(defn eval-line []
  (open-repl)
  (vim.cmd "SlimeSendCurrentLine"))

(defn eval-line-visual []
  (open-repl)
  (vim.cmd "'<,'>SlimeSend"))

(defn kill [bufnr?]
  (let [bufnr (or bufnr? (vim.api.nvim_get_current_buf))
        repl-bufnr (get-repl bufnr)]
    (when repl-bufnr
      (tset active-repls bufnr nil)
      (vim.cmd (string.format "bw! %d" repl-bufnr)))))

(defn reset [bufnr?]
  (let [bufnr (or bufnr? (vim.api.nvim_get_current_buf))
        repl-bufnr (get-repl bufnr)]
    (when repl-bufnr
      (kill bufnr)
      (open-repl bufnr))))
