(module dotfiles.rest-client
  {require {buffers dotfiles.buffers}})

(var rest-bufnr nil)

(defn toggle-rest-buf []
  (buffers.toggle-buf
    rest-bufnr
    (fn []
      (let [bufnr (vim.api.nvim_create_buf true false)]
        (vim.api.nvim_buf_set_option bufnr :filetype :rest)
        (vim.api.nvim_buf_set_name bufnr "REST Client")
        (vim.api.nvim_buf_attach bufnr false {:on_detach #(set rest-bufnr nil)})
        (set rest-bufnr bufnr)
        bufnr))))
