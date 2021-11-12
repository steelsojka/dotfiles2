(module dotfiles.module.plugin.vim-slime)

(def run "npm install -g ts-node")

(defn setup []
  (set vim.g.slime_target "neovim"))
