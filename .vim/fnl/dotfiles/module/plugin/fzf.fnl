(module dotfiles.module.plugin.fzf
  {require {nvim aniseed.nvim}})

(set nvim.g.fzf_files_options "--bind 'ctrl-l:execute(bat --paging=always {} > /dev/tty)'")
(set nvim.g.fzf_action {"ctrl-t" "tab split"
                        "ctrl-x" "split"
                        "ctrl-v" "vsplit"})

(nvim.command "highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#36353d")
