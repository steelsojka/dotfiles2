(module dotfiles.module.plugin.lightline)

(defn setup []
  (set vim.g.lightline {
    :colorscheme "tokyonight"
    :active {:left [[:mode :paste]
                    [:readonly :filename :modified]
                    [:gitsigns]]
             :right [[:lineinfo] [:percent] [:lspstatus]]}
    :component {:treesitter "%{luaeval('require(\"nvim-treesitter\").statusline()')}"
                :gitsigns "%{get(b:, 'gitsigns_status', '')}"
                :lspstatus "%{luaeval('require(\"dotfiles.status\").lsp()')}"}}))
