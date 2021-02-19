(module dotfiles.module.plugin.dashboard)

(set vim.g.dashboard_default_executive :telescope)
(set vim.g.dashboard_custom_shortcut
     {:find_history "SPC f r"
      :find_file "SPC p f"
      :new_file "SPC f n"
      :change_colorscheme "       "
      :find_word "SPC s p"
      :book_marks "SPC CR "
      :last_session "       "})
