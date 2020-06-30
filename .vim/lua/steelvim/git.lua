local M = {}

M._git_checkout_fzf = steel.fzf:create(function(_, branch)
  steel.command(string.format("!git checkout %s", vim.trim(branch)))
end)

-- Checks out a git branch using fzf
-- @param dir The directory to run fzf in
function M.checkout_git_branch_fzf(dir)
  M._git_checkout_fzf:execute {
    source = 'git branch',
    window = steel.fzf.float_window(),
    dir = dir
  }
end

return M
