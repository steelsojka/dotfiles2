(module dotfiles.module.plugin.nvim-autopairs)

(defn configure []
  (let [autopairs (require "nvim-autopairs")]
    (autopairs.setup
      {:enable_moveright false})))
