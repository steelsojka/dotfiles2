(module dotfiles.module.plugin.which-key)

(defn configure []
  (let [which-key (require "which-key")]
    (which-key.setup {})))
