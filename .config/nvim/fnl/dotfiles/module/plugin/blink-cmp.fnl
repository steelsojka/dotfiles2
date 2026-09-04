(module dotfiles.module.plugin.blink-cmp)

(defn configure []
  (let [blink-cmp (require "blink.cmp")]
    (blink-cmp.setup
     {:keymap
      {:preset "enter"}
      :appearance {:nerd_font_variant "mono"}
      :completion
      {:documentation {:auto_show true}
       :list {:selection {:preselect false :auto_insert false}}}
      :sources
      {:default ["lsp" "buffer" "path"]
       :providers
       {:buffer {:max_items 25
                 :opts {:get_bufnrs #(vim.api.nvim_list_bufs)}}}}
      :cmdline
      {:keymap {:preset "cmdline"}
       :completion {:menu {:auto_show true}}}
      :fuzzy {:implementation "prefer_rust_with_warning"}})))
