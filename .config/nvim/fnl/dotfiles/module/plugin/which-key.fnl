(module dotfiles.module.plugin.which-key)

(defn configure []
  (let [whick-key (require "which-key")]
    (which-key.setup {})))
