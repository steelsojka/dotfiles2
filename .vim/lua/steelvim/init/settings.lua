local HOME = vim.loop.os_homedir()

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
  cmdheight = 1,
  mouse = 'nv',
  showmode = false,
  splitbelow = true,
  splitright = true,
  inccommand = 'nosplit',
  shortmess = vim.o.shortmess .. 'c',
  completeopt = 'menuone,noinsert,noselect',
  complete = '.,b,w,u',
  gdefault = true,
  dictionary = '/usr/share/dict/words'
}

for key,value in pairs(settings) do
  if value == true then
    steel.ex.set(key)
  elseif value == false then
    steel.ex.set('no' .. key)
  else
    vim.o[key] = value
  end
end
