(module dotfiles.module.commands
  {require {nvim aniseed.nvim
            buffers dotfiles.buffers
            keymap dotfiles.keymap}})

(local highlight (require "vim.highlight"))

(keymap.create-augroups
  {:terminal [["TermOpen" "*" #(nvim.ex.setlocal "nospell" "nonumber")]]
   :startify [["User" "Startified" #(nvim.ex.setlocal "buflisted")]]
   :yank [["TextYankPost" "*" "silent!" #(highlight.on_yank {:timeout 400})]]
   ; :completion [["BufEnter" "*" #((. (require "completion") :on_attach))]]
   :edit [["BufWrite" "*" "silent!" #(buffers.trim-trailing-whitespace)]]})
