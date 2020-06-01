local fzf_to_qf_ref = steel.utils.funcref:create(function(_, lines)
  steel.qf.build_list(lines)
end , { name = 'fzf_to_qf' })

local globals = {
  fzf_layout= {
    window = steel.fzf.float_window()
  },
  fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit',
  },
  fzf_files_options = [[--bind 'ctrl-l:execute(bat --paging=always {} > /dev/tty)']],
  ale_linters = {
    javascript = { "eslint" };
    typescript = { "eslint", "tslint" };
  },
  ale_linters_explicit = 1,
  completion_timer_cycle = 200,
  completion_sorting = 'none',
  completion_enable_snippet = 'UltiSnips',
  completion_matching_strategy_list = { 'exact' },
  completion_enable_auto_signature = 1,
  completion_auto_change_source = 1,
  completion_chain_complete_list = {
    { complete_items = { 'lsp' } },
    { complete_items = { 'snippet' } },
    { mode = { '<c-p>' } },
    { mode = { '<c-n>' } }
  },
  diagnostic_enable_virtual_text = 0,
  diagnostic_insert_delay = 1,
  ['prettier#exec_cmd_async'] = 1,
  lightline = {
    colorscheme = 'one',
    active = {
      left = {
        { 'mode', 'paste' },
        { 'git_status', 'readonly', 'filename', 'modified' },
        { 'lsp_error_count' }
      },
      right = {
        { 'lineinfo' },
        { 'percent' }
      }
    },
    component = {
      git_status = [[%{luaeval('require(''steelvim/git'').get_git_status()')}]];
      lsp_error_count = [[%{luaeval('require(''steelvim/diagnostics'').get_status_line()')}]];
    }
  },
  ['sneak#label'] = true,
  doge_enable_mappings = false,
  caser_prefix = '<Space>cc',
  floaterm_winblend = 10,
  floaterm_position = 'center',
  floaterm_background = '#36353d',
  floaterm_width = vim.fn.float2nr(vim.o.columns * 0.9),
  floaterm_height = vim.fn.float2nr(vim.o.lines * 0.75),
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

steel.command [[highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#36353d]]

for key,value in pairs(globals) do
  vim.g[key] = value
end

steel.command(([[let g:fzf_action['ctrl-q'] = %s]]):format(fzf_to_qf_ref:get_vim_ref_string()))

