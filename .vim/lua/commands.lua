local nvim = require 'nvim'
local mappings = require 'mappings'
local utils = require 'utils'

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
    end}
  },

  terminal = {
    { 'TermOpen', '*', function() 
      nvim.ex.setlocal('nospell', 'nonumber')
    end}
  },

  startify = {
    { 'User', 'Startified', function()
      nvim.ex.setlocal('buflisted')
    end}
  }
}

nvim.command [[
command! -bang -nargs=? -complete=dir Files
  call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('right:60%') : fzf#vim#with_preview(), <bang>0)
]]

nvim.command [[command! -bang -nargs=* DRg call steelvim#grep(<q-args>, expand('%:p:h'), <bang>0)]]
nvim.command [[command! -bang -nargs=* Rg call steelvim#grep(<q-args>, getcwd(), <bang>0)]]
nvim.command [[command! -bang -nargs=* FlyDRg call luaeval('steelvim.flygrep(_A[1], _A[2], _A[3])', [<q-args>, expand('%:p:h'), <bang>0])]]
nvim.command [[command! -bang -nargs=* FlyRg call luaeval('steelvim.flygrep(_A[1], _A[2], _A[3])', [<q-args>, getcwd(), <bang>0])]]
nvim.command([[command! -nargs=0 InstallCocExtestions :CocInstall ]] .. utils.join(coc_extensions, ' '))
