local nvim = require 'nvim'
local colorizer = require 'colorizer'

local globals = {
  fzf_layout= {
    window = 'lua steelvim.float_fzf()'
  },
  coc_node_path = nvim.env.SYSTEM_NODE_PATH,
  coc_snippet_next = '<tab>',
  lightline = {
    colorscheme = 'one',
    active = {
      left = {
        { 'mode', 'paste' },
        { 'git_status', 'readonly', 'filename', 'modified' }
      },
      right = {
        { 'lineinfo' },
        { 'percent' }
      }
    },
    component_function = {
      git_status = 'GetGitStatus'
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

for key,value in pairs(globals) do
  nvim.g[key] = value
end
