(module dotfiles.terminal
  {require {nvim aniseed.nvim
            win dotfiles.window}})

(defn float-cmd [cmd]
  "Opens a terminl with an fzf floating window"
  (win.create-floating-window)
  (nvim.command (string.format "call termopen('%s', {'on_exit': {_ -> execute('q!') }})" cmd))
  (nvim.ex.normal "i"))

(defn open [is-local]
  "Opens terminal to the cwd or to the current files directory."
  (let [cwd (if is-local (nvim.fn.expand "%:p:h") (nvim.fn.getcwd))
        buf (nvim.create_buf true false)]
    (nvim.set_current_buf buf)
    (nvim.fn.termopen vim.g.tshell {: cwd})
    (nvim.ex.normal "i")))

(defn get-channel [bufnr?]
  (vim.api.nvim_buf_get_option (or bufnr? 0) "channel"))

(defn new-term-buf [cmd env? bufnr? options?]
  (let [new-bufnr (or bufnr? (vim.api.nvim_create_buf false false))
        env (or env? "")
        options (or options? {})
        current-buf (vim.api.nvim_get_current_buf)
        shell-cmd (string.format "%s %s %s \"%s\""
                                 env
                                 vim.g.tshell
                                 vim.g.tshell_cmd_flag
                                 cmd)]
    (vim.cmd (string.format "buffer %d" new-bufnr))
    (vim.fn.termopen shell-cmd options)
    (vim.api.nvim_set_current_buf current-buf)
    (let [channel (get-channel new-bufnr)]
      [new-bufnr channel])))
