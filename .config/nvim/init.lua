local data_dir = vim.fn.stdpath "data"

vim.cmd [[let mapleader = "\<Space>"]]
vim.cmd [[let g:mapleader = "\<Space>"]]

vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.ruler = true
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.undodir = data_dir .. "/undo"
vim.opt.backupdir = data_dir .. "/backups"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 15
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.timeoutlen = 300
vim.opt.grepprg = "rg --vimgrep --auto-hybrid-regex"
vim.opt.updatetime = 200
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.mouse = "nv"
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.inccommand = "nosplit"
vim.opt.completeopt = "menuone,noselect"
vim.opt.complete = ".,b,w,u"
vim.opt.gdefault = true
vim.opt.dictionary = "/usr/share/dict/words"
vim.opt.shell = vim.env.NVIM_SHELL
vim.opt.shortmess:append "c"
vim.opt.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"

vim.g.tshell = vim.env.NVIM_TSHELL
vim.g.tshell_cmd_flag = vim.env.NVIM_TSHELL_CMD_FLAG

-- vim.lsp.set_log_level("debug")

require "plugin_loader".startup()
