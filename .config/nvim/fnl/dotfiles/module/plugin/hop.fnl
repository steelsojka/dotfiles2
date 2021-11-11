(module dotfiles.module.plugin.hop)

(defn configure []
  (let [hop (require "hop")]
    (hop.setup)))

; (vim.cmd "highlight HopNextKey guifg=#ffffff gui=bold,underline")
; (vim.cmd "highlight HopNextKey1 guifg=#00dfff gui=bold,underline")
; (vim.cmd "highlight HopNextKey2 guifg=#2b8db3")
