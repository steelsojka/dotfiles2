local highlight = require 'vim.highlight'

steel.mappings.create_augroups {
  float_term = {
    { 'VimResized', '*', function()
      vim.g.floaterm_width = vim.fn.float2nr(vim.o.columns * 0.9)
      vim.g.floaterm_height = vim.fn.float2nr(vim.o.lines * 0.75)
    end };
  };
  terminal = {
    { 'TermOpen', '*', function() steel.ex.setlocal('nospell', 'nonumber') end };
  };
  startify = {
    { 'User', 'Startified', function() steel.ex.setlocal('buflisted') end };
  };
  yank = {
    { 'TextYankPost', '*', 'silent!', function() highlight.on_yank('IncSearch', 400, vim.v.event) end };
  };
  completion = {
    { 'BufEnter', '*', function() require 'completion'.on_attach() end };
  };
  edit = {
    { 'BufWrite', '*', 'silent!', function() steel.buf.trim_trailing_whitespace() end }
  };
}

steel.command [[command! -bang -nargs=* DRg call luaeval('steel.grep.grep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
steel.command [[command! -bang -nargs=* Rg call luaeval('steel.grep.grep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
steel.command [[command! -bang -nargs=* FlyDRg call luaeval('steel.grep.flygrep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
steel.command [[command! -bang -nargs=* FlyRg call luaeval('steel.grep.flygrep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
steel.command [[command! -bang -nargs=? -complete=dir Files 
  call luaeval('steel.files.fzf_files(unpack(_A))', [<q-args>, <bang>0])
]]
