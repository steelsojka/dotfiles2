local M = {}

-- Opens a floating terminal
-- @param full Whether the terminal is full screen
function M.float(full)
  local height

  if full then
    height = vim.fn.winheight(0)
  else
    local lines = vim.o.lines
    height = math.floor(lines * 0.6)
  end

  vim.g.floaterm_height = height
  steel.ex.FloatermToggle()
  steel.ex.normal 'i'
end

-- Opens a terminl with an fzf floating window
-- @param The command to run
function M.float_fzf_cmd(cmd)
  steel.fzf.create_floating_window()
  -- Open a term and exit on process exit
  steel.command(([[call termopen('%s', {'on_exit': {_ -> execute('q!') }})]]):format(cmd))
  steel.ex.normal 'i'
end

-- Opens terminal to the cwd or to the current files directory.
-- @param is_local Whether to open local to the current file directory
function M.open_term(is_local)
  local cwd = is_local and vim.fn.expand '%:p:h' or vim.fn.getcwd()
  local buf = vim.api.nvim_create_buf(true, false)

  vim.api.nvim_set_current_buf(buf)
  vim.fn.termopen(nvim.o.shell, { cwd = cwd })
  steel.ex.normal 'i'
end

return M
