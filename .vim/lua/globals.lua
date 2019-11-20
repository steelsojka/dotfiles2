local nvim = require 'nvim'

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

local function initialize()
  for key,value in pairs(globals) do
    nvim.g[key] = value
  end
end

return {
  initialize = initialize 
}
