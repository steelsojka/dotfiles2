(module dotfiles.module.plugin
  {require {core aniseed.core
            nvim aniseed.nvim
            util dotfiles.util}})

(core.run!
  (fn [path]
    (let [name (nvim.fn.fnamemodify path ":t:r")]
      (require (.. "dotfiles.module.plugin." name))))
  (util.glob (.. (nvim.fn.stdpath :config) "/lua/dotfiles/module/plugin/*.lua")))
