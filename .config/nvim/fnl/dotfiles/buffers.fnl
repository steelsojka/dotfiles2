(module dotfiles.buffers
  {require {nvim aniseed.nvim
            core aniseed.core}})

(var should-trim-ws true)

(defn toggle-trim-trailing-ws []
  (set should-trim-ws (not should-trim-ws))
  (print (.. "Trim whitespace: " (tostring should-trim-ws))))

(defn trim-trailing-whitespace []
  (when should-trim-ws
    (let [saved (nvim.fn.winsaveview)]
      (nvim.command "keeppatterns %s/\\s\\+$//e")
      (nvim.fn.winrestview saved))))

(defn is-buf-visible [bufnr]
  (let [windows (vim.fn.win_findbuf bufnr)]
    (> (length windows) 0)))

(defn for-each-win [bufnr func]
  (each [_ win (ipairs (vim.fn.win_findbuf bufnr))]
    (func win)))

(defn toggle-buf [bufnr factory]
  (if (and bufnr (is-buf-visible bufnr))
    (do
      (for-each-win bufnr #(vim.api.nvim_win_close $1 false))
      nil)
    (let [new-bufnr (if (and bufnr (vim.api.nvim_buf_is_valid bufnr))
                      bufnr
                      (factory))]
      (vim.cmd "split")
      (vim.cmd (string.format "buffer %d" new-bufnr))
      new-bufnr)))
