local nvim = require 'nvim'

local HOME = nvim.fn.expand('~')

local settings = {
  number = true,
  termguicolors = true,
  ruler = true,
  undofile = true,
  undodir = HOME .. '/.vim/undo',
  backup = true,
  backupdir = HOME .. '/.vim/backups',
  shiftwidth = 2,
  tabstop = 2,
  expandtab = true,
  smartcase = true,
  ignorecase = true,
  scrolloff = 5,
  sidescrolloff = 15,
  hidden = true,
  wrap = false,
  timeoutlen = 300,
  grepprg = 'rg --vimgrep --auto-hybrid-regex',
  updatetime = 200,
  signcolumn = 'yes',
  cmdheight = 2,
  mouse = 'nv',
  showmode = false,
  splitbelow = true,
  splitright = true,
  inccommand = 'nosplit',
  shortmess = nvim.o.shortmess .. 'c',
  gdefault = true,
  dictionary = '/usr/share/dict/words'
}

nvim.ex.colorscheme('OceanicNext')

for key,value in pairs(settings) do
  if value == true then
    nvim.ex.set(key)
  elseif value == false then
    nvim.ex.set('no' .. key)
  else
    nvim.o[key] = value
  end
end
