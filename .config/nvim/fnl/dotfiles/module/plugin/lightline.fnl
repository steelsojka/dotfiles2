(module dotfiles.module.plugin.lightline
  {require {nvim aniseed.nvim}})

(set vim.g.lightline {
  :colorscheme "tokyonight"
  :active {:left [[:mode :paste]
                  [:readonly :filename :modified]
                  [:gitsigns]]
           :right [[:lineinfo] [:percent]]}
  :component {:treesitter "%{luaeval('require(\"nvim-treesitter\").statusline()')}"
              :gitsigns "%{get(b:, 'gitsigns_status', '')}"}})
