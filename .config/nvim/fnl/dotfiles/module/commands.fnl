(module dotfiles.module.commands
  {require {nvim aniseed.nvim
            buffers dotfiles.buffers
            keymap dotfiles.keymap}})

(local highlight (require "vim.highlight"))

(keymap.create-augroups
  {:terminal [["TermOpen" "*" #(nvim.ex.setlocal "nospell" "nonumber")]]
   :startify [["User" "Startified" #(nvim.ex.setlocal "buflisted")]]
   :yank [["TextYankPost" "*" "silent!" #(highlight.on_yank {:timeout 400})]]
   :edit [["BufWrite" "*" "silent!" #(buffers.trim-trailing-whitespace)]]
   :win-resize [["VimResized" "*" "silent!" "call feedkeys(\"\\<C-W>=\", \"n\")"]]
   :syntax [["BufNew,BufRead" "Jenkinsfile" "silent!" "set ft=groovy"]]})
