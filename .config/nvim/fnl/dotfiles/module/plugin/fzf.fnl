(module dotfiles.module.plugin.fzf-vim
  {require {funcref dotfiles.funcref
            win dotfiles.window
            fzf dotfiles.fzf}})

(def- fzf-to-qf-ref
  (funcref.create
    (fn [_ lines] true)
    {:name :fzf-to-qf}))

(defn setup []
  (set vim.g.fzf_layout {:window (win.float-window)})
  (set vim.g.fzf_files_options "--bind 'ctrl-l:execute(bat --paging=always {} > /dev/tty)'")
  (set vim.g.fzf_action {"ctrl-t" "tab split"
                          "ctrl-x" "split"
                          "ctrl-v" "vsplit"})
  (vim.cmd "highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#36353d")
  (vim.cmd (string.format "let g:fzf_action['ctrl-q'] = %s" (fzf-to-qf-ref.get-vim-ref-string))))
