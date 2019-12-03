local nvim = require 'nvim'
local Fzf = require 'fzf/fzf'

-- Opens a floating terminal
-- @param full Whether the terminal is full screen
local function float(full)
  local height

  if full then
    height = nvim.fn.winheight(0)
  else
    local lines = nvim.o.lines
    height = math.floor(lines * 0.6)
  end

  nvim.g.floaterm_height = height
  nvim.ex.FloatermToggle()
  nvim.ex.normal 'i'
end

-- Opens a terminl with an fzf floating window
-- @param The command to run
local function float_fzf_cmd(cmd)
  Fzf.create_floating_window()
  -- Open a term and exit on process exit
  nvim.command('call termopen(\'' .. cmd .. '\', {\'on_exit\': {_ -> execute(\'q!\') }})')
  nvim.ex.normal 'i'
end

-- Opens terminal to the cwd or to the current files directory.
-- @param is_local Whether to open local to the current file directory
local function open_term(is_local)
  local cwd = is_local and nvim.fn.expand '%:p:h' or nvim.fn.getcwd()
  local buf = nvim.create_buf(true, false)

  nvim.set_current_buf(buf)
  nvim.fn.termopen(nvim.o.shell, { cwd = cwd })
  nvim.ex.normal 'i'
end

return {
  float = float,
  float_fzf_cmd = float_fzf_cmd,
  open = open_term
}
