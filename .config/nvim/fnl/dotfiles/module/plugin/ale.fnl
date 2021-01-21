(module dotfiles.module.plugin.ale
  {require {nvim aniseed.nvim}})

(set nvim.g.ale_linters {:javascript [:eslint]
                         :typescript [:eslint :tslint]})
(set nvim.g.ale_linters_explicit 1)
