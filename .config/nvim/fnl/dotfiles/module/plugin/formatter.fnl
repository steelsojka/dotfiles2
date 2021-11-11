(module dotfiles.module.plugin.formatter)

(local formatters
  {:prettier #{:exe "npxx"
               :args ["prettier"
                      "--stdin-filepath"
                      (vim.api.nvim_buf_get_name 0)]
               :stdin true}
   :eslint #{:exe "npxx"
             :args ["eslint"
                    "--stdin-filename"
                    (vim.api.nvim_buf_get_name 0)
                    "--fix"]
             :stdin false}})

(local use-format
  (fn [default-formatter]
    (fn [...]
      (let [formatter-name (or vim.b.formatter
                               (or vim.g.formatter default-formatter))
            formatter-fn (. formatters formatter-name)]
        (formatter-fn ...)))))

(defn configure []
  (let [formatter (require :formatter)]
    (formatter.setup
      {:logging false
       :filetype
       {:javascript [(use-format :eslint)]
        :typescript [(use-format :eslint)]
        :javascriptreact [(use-format :eslint)]
        :typescriptreact [(use-format :eslint)]
        :html [(use-format :prettier)]}})))
