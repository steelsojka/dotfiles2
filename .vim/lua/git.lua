local nvim = require 'nvim'
local utils = require 'utils/utils'
local Fzf = require 'fzf/fzf'

local git_checkout_fzf = Fzf:create '!git checkout'

local function get_git_status()
  local status = vim.fn['fugitive#head']()

  if vim.fn.winwidth(0) > 80 then
    return #status > 30 and (status:sub(0, 27) .. '...') or status
  end
  
  return ''
end

-- Checks out a git branch using fzf
-- @param dir The directory to run fzf in
local function checkout_git_branch_fzf(dir)
  git_checkout_fzf:execute {
    source = 'git lob', 
    window = Fzf.float_window(),
    dir = dir 
  }
end

return {
  get_git_status = get_git_status,
  checkout_git_branch_fzf = checkout_git_branch_fzf
}
