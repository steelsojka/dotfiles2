local fzf_to_qf_ref = steel.utils.funcref:create(function(_, lines)
  steel.qf.build_list(lines)
end , { name = 'fzf_to_qf' })

local globals = {
  fzf_layout= {
    window = steel.fzf.float_window()
  },
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

-- steel.command [[highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#36353d]]

for key,value in pairs(globals) do
  vim.g[key] = value
end

steel.command(([[let g:fzf_action['ctrl-q'] = %s]]):format(fzf_to_qf_ref:get_vim_ref_string()))
