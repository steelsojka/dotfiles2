(module dotfiles.module.plugin.formatter)

(let [formatter (require :formatter)
      prettier #{:exe :prettier
                 :args ["--stdin-filepath"
                        (vim.api.nvim_buf_get_name 0)]
                 :stdin true}]
  (formatter.setup
    {:logging false
     :filetype
     {:javascript [prettier]
      :typescript [prettier]}}))
