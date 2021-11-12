(module dotfiles.module.plugin.nvim-cmp)

(defn configure []
  (let [cmp (require "cmp")]
    (do
      (cmp.setup
        {:snippet
         {:expand #(vim.fn.vsnip#anonymous $.body)}
         :mapping
         {"<C-d>" (cmp.mapping
                    (cmp.mapping.scroll_docs -4)
                    ["i" "c"])
          "<C-f>" (cmp.mapping
                    (cmp.mapping.scroll_docs 4)
                    ["i" "c"])
          "<C-Space>" (cmp.mapping
                    (cmp.mapping.complete)
                    ["i" "c"])
          "<C-y>" cmp.config.disable
          "<C-e>" (cmp.mapping
                    {:i (cmp.mapping.abort)
                     :c (cmp.mapping.close)})
          "<CR>" (cmp.mapping.confirm {:select true})}
         :sources (cmp.config.sources
                    [{:name "nvim_lsp"}
                     {:name "vsnip"}]
                    [{:name "orgmode"}
                     {:name "buffer"}])})
      (cmp.setup.cmdline "/" {:sources [{:name "buffer"}]})
      (cmp.setup.cmdline ":" {:sources (cmp.config.sources
                                         [{:name "path"}]
                                         [{:name "cmdline"}])}))))
