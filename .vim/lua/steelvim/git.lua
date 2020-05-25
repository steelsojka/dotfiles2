local M = {}

M._git_checkout_fzf = steel.fzf:create '!git checkout'

function M.get_git_status()
  local status = vim.fn['fugitive#head']()

  if vim.fn.winwidth(0) > 80 then
    return #status > 30 and (status:sub(0, 27) .. '...') or status
  end

  return ''
end

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
