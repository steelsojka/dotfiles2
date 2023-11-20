(module dotfiles.module.plugin.tokyonight)

(defn configure []
  (let [tokyo (require "tokyonight")]
    (tokyo.setup {:style "night"
                  :sidebars ["qf" "vista_kind" "terminal"]
                  :on_colors (fn [colors]
                               (set colors.bg_sidebar "#16161e"))}))
  (pcall #(vim.cmd "colorscheme tokyonight")))
