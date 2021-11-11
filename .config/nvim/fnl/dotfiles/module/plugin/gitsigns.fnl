(module dotfiles.module.plugin.gitsigns)

(defn configure []
  (let [gitsigns (require "gitsigns")]
    (gitsigns.setup {:keymaps {}})))
