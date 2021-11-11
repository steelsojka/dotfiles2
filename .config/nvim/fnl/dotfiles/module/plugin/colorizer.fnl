(module dotfiles.module.plugin.colorizer)

(defn configure []
  (let [colorizer (require :colorizer)]
    (colorizer.setup [
      "css"
      "sass"
      "less"
      "typescript"
      "javascript"
      "vim"
      "html"
      "jst"
      "lua"])))
