(module dotfiles.module.plugin.tokyonight)

(defn setup []
  (set vim.g.tokyonight_sidebars ["qf" "vista_kind" "terminal" "packer"])
  (set vim.g.tokyonight_colors {:bg_sidebar "#16161e"})
  (set vim.g.tokyonight_style "night")
  (pcall #(vim.cmd "colorscheme tokyonight")))
