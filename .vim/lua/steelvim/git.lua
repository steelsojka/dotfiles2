local M = {}

M._git_checkout_fzf = steel.fzf:create '!git checkout'

-- Checks out a git branch using fzf
-- @param dir The directory to run fzf in
function M.checkout_git_branch_fzf(dir)
  M._git_checkout_fzf:execute {
    source = 'git lob',
    window = steel.fzf.float_window(),
    dir = dir
  }
end

return M
