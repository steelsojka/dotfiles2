(module dotfiles.pickers)

(fn relative-path [from to]
  (let [from-parts (vim.split (vim.fs.normalize from) "/" {:plain true})
        to-parts (vim.split (vim.fs.normalize to) "/" {:plain true})]
    (while (and (> (# from-parts) 0)
                (> (# to-parts) 0)
                (= (. from-parts 1) (. to-parts 1)))
      (table.remove from-parts 1)
      (table.remove to-parts 1))
    (table.concat
     (vim.list_extend
      (vim.tbl_map (fn [_] "..") from-parts)
      to-parts)
     "/")))

(defn insert-relative-path []
  (let [source-buf (vim.api.nvim_get_current_buf)
       source-dir (vim.fs.dirname (vim.api.nvim_buf_get_name source-buf))
       [row col] (vim.api.nvim_win_get_cursor 0)]
       (Snacks.picker.files
        {:cwd (vim.fn.getcwd)
         :confirm
         (fn [picker item]
           (let [path (relative-path source-dir (vim.fs.abspath item.file))]
             (picker:close)
             (print path (vim.fs.abspath item.file) source-dir)
             ; Wait for the picker to finish closing before changing the source buffer.
             (vim.schedule
              (fn []
                (print source-buf path)
                (when (vim.api.nvim_buf_is_valid source-buf)
                  (vim.api.nvim_buf_set_text
                   source-buf
                   (- row 1)
                   col
                   (- row 1)
                   col
                   [path]))))))})))

