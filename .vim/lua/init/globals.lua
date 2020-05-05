local nvim = require 'nvim'
local colorizer = require 'colorizer'
local Fzf = require 'fzf/fzf'
local Funcref = require 'utils/funcref'
local quickfix = require 'quickfix'

local fzf_to_qf_ref = Funcref:create(function(ref, lines)
  quickfix.build_list(lines) 
end , { name = 'fzf_to_qf' })

local globals = {
  fzf_layout= {
    window = Fzf.float_window()
  },
  coc_node_path = nvim.env.SYSTEM_NODE_PATH,
  coc_snippet_next = '<tab>',
  fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit',
  },
  lightline = {
    colorscheme = 'one',
    active = {
      left = {
        { 'mode', 'paste' },
        { 'git_status', 'readonly', 'filename', 'modified' }
      },
      right = {
        { 'lineinfo' },
        { 'percent' },
        { 'coc_status' }
      }
    },
    component = {
      git_status = [[%{luaeval('require(''git'').get_git_status()')}]],
      coc_status = [[%{coc#status()}]]
    }
  },
  ['sneak#label'] = true,
  doge_enable_mappings = false,
  caser_prefix = '<Space>cc',
  floaterm_winblend = 10,
  floaterm_position = 'center',
  floaterm_background = '#36353d',
  floaterm_width = nvim.fn.float2nr(nvim.o.columns * 0.9),
  floaterm_height = nvim.fn.float2nr(nvim.o.lines * 0.75),
  typescript_compiler_binary = 'node_modules/.bin/tsc',
  typescript_compiler_options = '--noEmit',
  startify_custom_header = {
    [[                                 __                ]],
    [[    ___      __    ___   __  __ /\_\    ___ ___    ]],
    [[  /' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  ]],
    [[  /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[  \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[   \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    [[                                      Steel Edition]]
  }
}

nvim.command [[highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#36353d]]

for key,value in pairs(globals) do
  nvim.g[key] = value
end

nvim.command(([[let g:fzf_action['ctrl-q'] = %s]]):format(fzf_to_qf_ref:get_vim_ref_string()))

