(module dotfiles.module.commands
  {require {nvim aniseed.nvim
            buffers dotfiles.buffers
            keymap dotfiles.keymap}})

(keymap.create-augroups
  {:terminal [["TermOpen" "*" #(nvim.ex.setlocal "nospell" "nonumber")]]
   :startify [["User" "Startified" #(nvim.ex.setlocal "buflisted")]]
   :yank [["TextYankPost" "*" "silent!" #(lib.vim_highlight.on_yank {:timeout 400})]]
   :edit [["BufWrite" "*" "silent!" #(buffers.trim-trailing-whitespace)]]})
