(module dotfiles.module.plugin.lightline
  {require {nvim aniseed.nvim}})

(set vim.g.lightline {
  :colorscheme :one
  :active {:left [[:mode :paste]
                  [:readonly :filename :modified]
                  [:lsp_status]]
           :right [[:lineinfo] [:percent]]}
  :component {:lsp_status "%{luaeval('require(''lsp-status'').status()')}"
              :treesitter "%{luaeval('require(\"nvim-treesitter\").statusline()')}"}})
