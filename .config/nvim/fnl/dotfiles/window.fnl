(module dotfiles.window
  {require {nvim aniseed.nvim
            funcref dotfiles.funcref}})

(defn create-floating-window [on-close]
  (let [buf (nvim.create_buf false true)
        columns nvim.o.columns
        lines nvim.o.lines
        width (math.floor (- columns (/ (* columns 2) 20)))
        height (- lines 3)
        y height
        x (math.floor (/ (- columns width) 2))]
    (when on-close
      (nvim.buf_attach buf false {:on_detach (nvim.schedule_wrap on-close)}))
    (nvim.fn.setbufvar buf "&signcolumn" :no)
    (nvim.open_win buf true {:relative :editor
                             :row y
                             :col x
                             :width width
                             :height height})
    (nvim.ex.setlocal "winblend=10")))

(defn float-window [on-close]
  (if on-close
    (let [fn-ref (funcref.create
                   (fn [ref]
                     (on-close)
                     (ref.unsubscribe)))]
      (string.format "lua require'dotfiles.window'['create-floating-window'](%s)" (fn-ref.get-lua-ref-string)))
    "lua require'dotfiles.window'['create-floating-window']()"))
