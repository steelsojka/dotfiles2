(module dotfiles.module.plugin.mason)

(defn configure []
  (let [mason (require "mason")]
    (mason.setup)))
