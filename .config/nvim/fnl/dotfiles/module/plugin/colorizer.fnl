(module dotfiles.module.plugin.colorizer)

(local colorizer (require :colorizer))
(colorizer.setup [
  "css"
  "sass"
  "less"
  "typescript"
  "javascript"
  "vim"
  "html"
  "jst"
  "lua"])
