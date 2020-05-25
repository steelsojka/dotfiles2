local highlight = require 'vim.highlight'

steel.mappings.create_augroups {
  float_term = {
    { 'VimResized', '*', function()
      vim.g.floaterm_width = vim.fn.float2nr(vim.o.columns * 0.9)
      vim.g.floaterm_height = vim.fn.float2nr(vim.o.lines * 0.75)
    end }
  },

  terminal = {
    { 'TermOpen', '*', function() steel.ex.setlocal('nospell', 'nonumber') end }
  },

  startify = {
    { 'User', 'Startified', function() steel.ex.setlocal('buflisted') end }
  },

  yank = {
    { 'TextYankPost', '*', 'silent!', function() highlight.on_yank('IncSearch', 400, vim.v.event) end }
  }
  -- lsp = {
    -- { 'CursorHold', '*', 'silent', function() vim.lsp.buf.document_highlight() end },
    -- { 'CursorMoved', '*', 'silent', function() vim.lsp.buf.clear_references() end }
  -- }
}

steel.command [[command! -bang -nargs=* DRg call luaeval('require(''steelvim/grep'').grep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
steel.command [[command! -bang -nargs=* Rg call luaeval('require(''steelvim/grep'').grep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
steel.command [[command! -bang -nargs=* FlyDRg call luaeval('require(''steelvim/grep'').flygrep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
steel.command [[command! -bang -nargs=* FlyRg call luaeval('require(''steelvim/grep'').flygrep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
steel.command [[command! -bang -nargs=? -complete=dir Files 
  call luaeval('require(''steelvim/files'').fzf_files(unpack(_A))', [<q-args>, <bang>0])
]]
