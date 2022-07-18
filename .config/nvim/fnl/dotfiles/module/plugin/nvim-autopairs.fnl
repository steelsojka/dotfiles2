(module dotfiles.module.plugin.nvim-autopairs)

(defn configure []
  (let [autopairs (require "nvim-autopairs")
        cmp-autopairs (require "nvim-autopairs.completion.cmp")
        cmp-event (. (require "cmp") :event)]
    (cmp-event:on "confirm_done" (cmp-autopairs.on_confirm_done))
    (autopairs.setup {})))
