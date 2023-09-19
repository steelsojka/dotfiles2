(module dotfiles.module.plugin.nvim-web-devicons)

(defn configure []
  (let [devicons (require "nvim-web-devicons")]
    (devicons.setup {})))
