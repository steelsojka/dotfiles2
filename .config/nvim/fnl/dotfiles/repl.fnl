(module dotfiles.repl
  {require {buffers dotfiles.buffers
            terminal dotfiles.terminal
            core aniseed.core}})

(var repls
  {:javascript {:cmd #"node"
                :env #(let [cwd (vim.fn.getcwd)]
                        (string.format "NODE_PATH=%q" cwd))}
   :typescript {:cmd #(let [cwd (vim.fn.getcwd)]
                        (string.format "ts-node --dir %q" cwd))
                :env #""}})

(tset repls :typescriptreact repls.typescript)
(tset repls :javascriptreact repls.javascriptreact)

(local active-repls {})

(defn get-repl [bufnr?]
  (let [bufnr (or bufnr? (vim.api.nvim_get_current_buf))]
    (or (. active-repls bufnr) [])))

(defn kill [bufnr?]
  (let [bufnr (or bufnr? (vim.api.nvim_get_current_buf))
        [repl-bufnr] (get-repl bufnr)]
    (when repl-bufnr
      (tset active-repls bufnr nil)
      (vim.cmd (string.format "bw! %d" repl-bufnr)))))

(defn create-repl [bufnr cmd env]
  (let [[new-bufnr] (terminal.new-term-buf cmd env nil {:on_exit #(kill bufnr)})]
    (tset active-repls bufnr [new-bufnr])
    new-bufnr))

(defn open-repl [bufnr? ft?]
  (let [bufnr (or bufnr? (vim.api.nvim_get_current_buf))
        [existing-repl] (get-repl bufnr)
        ft (or ft? (vim.api.nvim_buf_get_option bufnr "filetype"))
        repl-def (. repls ft)
        current-window (vim.api.nvim_get_current_win)]
    (var repl-bufnr existing-repl)
    (do
      (when (not existing-repl)
        (if (not repl-def)
          (print (.. "No REPL definition for " ft))
          (set repl-bufnr (create-repl
                            bufnr
                            (repl-def.cmd)
                            (repl-def.env)))))
      (when (and repl-bufnr (not (buffers.is-buf-visible repl-bufnr)))
        (vim.cmd "vsplit")
        (vim.cmd (string.format "buffer %d" repl-bufnr))
        (let [jobid (vim.api.nvim_buf_get_option repl-bufnr "channel")]
          (vim.api.nvim_buf_set_var bufnr "slime_config" {: jobid})
          (vim.api.nvim_set_current_win current-window))))))

(defn select-repl [bufnr?]
  (vim.ui.select
    (core.keys repls)
    {:kind "string"}
    #(when $ (open-repl bufnr? $))))

(defn eval-line []
  (open-repl)
  (vim.cmd "SlimeSendCurrentLine"))

(defn eval-line-visual []
  (open-repl)
  (vim.cmd "'<,'>SlimeSend"))

(defn reset [bufnr?]
  (let [bufnr (or bufnr? (vim.api.nvim_get_current_buf))
        [repl-bufnr ft] (get-repl bufnr)]
    (when repl-bufnr
      (kill bufnr)
      (open-repl bufnr ft))))
