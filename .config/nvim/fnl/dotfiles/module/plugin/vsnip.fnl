(module dotfiles.module.plugin.vsnip)

(defn setup []
  (let [config-dir (vim.fn.stdpath "config")]
    (set vim.g.vsnip_snippet_dir (.. config-dir "/snippets"))
    (set vim.g.vsnip_filetypes
         {:javascriptreact ["javascript"]
          :typescriptreact ["typescript"]})))
