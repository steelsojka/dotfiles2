(module dotfiles.module.plugin.headwind)

(let [headwind (require "headwind")]
  (headwind.setup {:run_on_save false
                   :use_treesitter true}))
