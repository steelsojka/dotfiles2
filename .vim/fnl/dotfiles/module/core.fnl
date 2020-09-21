(module dotfiles.module.core
  {require {core aniseed.core
            nvim aniseed.nvim}})

(def- home-dir (vim.loop.os_homedir))

(nvim.ex.colorscheme "OceanicNext")

(set nvim.o.number true)
(set nvim.o.termguicolors true)
(set nvim.o.ruler true)
(set nvim.o.undofile true)
(set nvim.o.backup true)
(set nvim.o.undodir (.. home-dir "/.vim/undo"))
(set nvim.o.backupdir (.. home-dir "/.vim/backups"))
(set nvim.o.shiftwidth 2)
(set nvim.o.tabstop 2)
(set nvim.o.expandtab true)
(set nvim.o.smartcase true)
(set nvim.o.ignorecase true)
(set nvim.o.scrolloff 15)
(set nvim.o.hidden true)
(set nvim.o.wrap true)
(set nvim.o.timeoutlen 300)
(set nvim.o.grepprg "rg --vimgrep --auto-hybrid-regex")
(set nvim.o.updatetime 200)
(set nvim.o.signcolumn :yes)
(set nvim.o.cmdheight 1)
(set nvim.o.mouse :nv)
(set nvim.o.showmode false)
(set nvim.o.splitbelow true)
(set nvim.o.splitright true)
(set nvim.o.inccommand :nosplit)
(set nvim.o.shortmess (.. nvim.o.shortmess :c))
(set nvim.o.completeopt "menuone,noinsert,noselect")
(set nvim.o.complete ".,b,w,u")
(set nvim.o.gdefault true)
(set nvim.o.dictionary "/usr/share/dict/words")
(set nvim.o.shell "zsh")

(set nvim.wo.foldmethod :expr)
(set nvim.wo.foldexpr "nvim_treesitter#foldexpr()")
