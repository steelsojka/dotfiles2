(module dotfiles.module.plugin.headwind)

(defn configure []
  (let [headwind (require "headwind")]
    (headwind.setup {:run_on_save false
                     :use_treesitter true})))
