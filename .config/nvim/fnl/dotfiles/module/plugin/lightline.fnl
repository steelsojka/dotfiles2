(module dotfiles.module.plugin.lightline
  {require {nvim aniseed.nvim}})

(set vim.g.lightline {
  :colorscheme :one
  :active {:left [[:mode :paste]
                  [:readonly :filename :modified]]
           :right [[:lineinfo] [:percent]]}
  :component {:treesitter "%{luaeval('require(\"nvim-treesitter\").statusline()')}"}})
