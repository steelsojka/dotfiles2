
(module dotfiles.module.plugin.nvim-cmp)

; Text = "󰉿",
; Method = "󰆧",
; Function = "󰊕",
; Constructor = "",
; Field = "󰜢",
; Variable = "󰀫",
; Class = "󰠱",
; Interface = "",
; Module = "",
; Property = "󰜢",
; Unit = "󰑭",
; Value = "󰎠",
; Enum = "",
; Keyword = "󰌋",
; Snippet = "",
; Color = "󰏘",
; File = "󰈙",
; Reference = "󰈇",
; Folder = "󰉋",
; EnumMember = "",
; Constant = "󰏿",
; Struct = "󰙅",
; Event = "",
; Operator = "󰆕",
; TypeParameter = "",

(defn configure []
  (let [cmp (require "cmp")
        lspkind (require "lspkind")]
    (do
      (cmp.setup
        {:snippet
         {:expand #(vim.fn.vsnip#anonymous $.body)}
         :formatting
         {:format (lspkind.cmp_format
                    {:mode "symbol_text"
                     :menu {:buffer "[Buf]"
                            :nvim_lsp "[LSP]"
                            :vsnip "[Snip]"
                            :codeium "[AI]"}
                     :maxwidth 50
                     :ellipsis_char "..."
                     :symbol_map {:Codeium ""}})}
         :mapping
          (cmp.mapping.preset.insert
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
             "<CR>" (cmp.mapping.confirm {:select true})
             "<Tab>" (cmp.mapping (cmp.mapping.select_next_item))
             "<S-Tab>" (cmp.mapping (cmp.mapping.select_prev_item))})
         :sources (cmp.config.sources
                    [{:name "nvim_lsp"}
                     {:name "vsnip"}
                     {:name "orgmode"}
                     {:name "codeium"}]
                    [{:name "buffer"
                      :max_item_count 25
                      :option
                      {:get_bufnrs #(vim.api.nvim_list_bufs)}}])})
      (cmp.setup.cmdline "/" {:sources [{:name "buffer"}]
                              :mapping (cmp.mapping.preset.cmdline)})
      (cmp.setup.cmdline ":" {:sources (cmp.config.sources
                                         [{:name "path"}]
                                         [{:name "cmdline"}])
                              :mapping (cmp.mapping.preset.cmdline)}))))
