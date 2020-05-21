local nvim = require 'nvim'
local mappings = require 'utils/mappings'
local highlight = require 'vim.highlight'

mappings.create_augroups {
  float_term = {
    { 'VimResized', '*', function()
      nvim.g.floaterm_width = vim.fn.float2nr(nvim.o.columns * 0.9)
      nvim.g.floaterm_height = vim.fn.float2nr(nvim.o.lines * 0.75)
    end }
  },

  terminal = {
    { 'TermOpen', '*', function() nvim.ex.setlocal('nospell', 'nonumber') end }
  },

  startify = {
    { 'User', 'Startified', function() nvim.ex.setlocal('buflisted') end }
  },

  yank = {
    { 'TextYankPost', '*', 'silent!', function() highlight.on_yank('IncSearch', 400, vim.v.event) end }
  }
  -- lsp = {
    -- { 'CursorHold', '*', 'silent', function() vim.lsp.buf.document_highlight() end },
    -- { 'CursorMoved', '*', 'silent', function() vim.lsp.buf.clear_references() end }
  -- }
}

nvim.command [[command! -bang -nargs=* DRg call luaeval('require(''grep'').grep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
nvim.command [[command! -bang -nargs=* Rg call luaeval('require(''grep'').grep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
nvim.command [[command! -bang -nargs=* FlyDRg call luaeval('require(''grep'').flygrep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
nvim.command [[command! -bang -nargs=* FlyRg call luaeval('require(''grep'').flygrep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
nvim.command [[command! -bang -nargs=? -complete=dir Files 
  call luaeval('require(''files'').fzf_files(unpack(_A))', [<q-args>, <bang>0])
]]
