local nvim = require 'nvim'
local mappings = require 'utils/mappings'
local utils = require 'utils/utils'

local coc_extensions = {
  'coc-tsserver',
  'coc-json',
  'coc-git',
  'coc-java',
  'coc-pairs',
  'coc-prettier',
  'coc-css',
  'coc-html',
  'coc-yank',
  'coc-lists',
  'coc-snippets',
  'coc-eslint',
  'coc-angular',
  'coc-dictionary'
}

mappings.create_augroups {
  float_term = {
    { 'VimResized', '*', function() 
      nvim.g.floaterm_width = nvim.fn.float2nr(nvim.o.columns * 0.9)
      nvim.g.floaterm_height = nvim.fn.float2nr(nvim.o.lines * 0.75)
    end }
  },

  terminal = {
    { 'TermOpen', '*', function() nvim.ex.setlocal('nospell', 'nonumber') end }
  },

  startify = {
    { 'User', 'Startified', function() nvim.ex.setlocal('buflisted') end }
  },
  coc_nvim = {
    { 'CursorHold', '*', 'silent', function() nvim.fn.CocActionAsync('highlight') end },
    { 'User', 'CocJumpPlaceholder', function() nvim.fn.CocActionAsync('showSignatureHelp') end }
  }
}

nvim.command [[
command! -bang -nargs=? -complete=dir Files
  call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('right:60%') : fzf#vim#with_preview(), <bang>0)
]]

nvim.command [[command! -bang -nargs=* DRg call luaeval('require(''grep'').grep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
nvim.command [[command! -bang -nargs=* Rg call luaeval('require(''grep'').grep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
nvim.command [[command! -bang -nargs=* FlyDRg call luaeval('require(''grep'').flygrep(unpack(_A))', [<q-args>, expand('%:p:h'), <bang>0])]]
nvim.command [[command! -bang -nargs=* FlyRg call luaeval('require(''grep'').flygrep(unpack(_A))', [<q-args>, getcwd(), <bang>0])]]
nvim.command([[command! -nargs=0 InstallCocExtestions :CocInstall ]] .. utils.join(coc_extensions, ' '))
