(module dotfiles.module.plugin.dressing)

(defn configure []
  (let [dressing (require "dressing")]
    (dressing.setup
      {:select {:enabled false}})))
