local highlight = require 'vim.highlight'

steel.mappings.create_augroups {
  terminal = {
    { 'TermOpen', '*', function() steel.ex.setlocal('nospell', 'nonumber') end };
  };
  startify = {
    { 'User', 'Startified', function() steel.ex.setlocal('buflisted') end };
  };
  yank = {
    { 'TextYankPost', '*', 'silent!', function() highlight.on_yank { timeout = 400 } end };
  };
  completion = {
    { 'BufEnter', '*', function() require 'completion'.on_attach() end };
  };
  edit = {
    { 'BufWrite', '*', 'silent!', function() steel.buf.trim_trailing_whitespace() end }
  };
  folds = {
    { 'Syntax', '*', 'silent! normal! zR' }
  };
}

steel.command [[command! -bang -nargs=* DRg call luaeval('steel.grep.grep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
steel.command [[command! -bang -nargs=* Rg call luaeval('steel.grep.grep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
steel.command [[command! -bang -nargs=* FlyDRg call luaeval('steel.grep.flygrep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
steel.command [[command! -bang -nargs=* FlyRg call luaeval('steel.grep.flygrep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
