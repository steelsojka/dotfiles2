local modes = {
  -- "man ls"
  MAN_PAGER = "man_pager",
  -- "git log"
  GIT_PAGER = "git_pager",
  -- General GIT viewing. Replaces lazygit.
  GIT = "git",
  -- "git diff"
  GIT_DIFF = "git_diff"
}

local ALL_MODES = vim.tbl_values(modes)

return setmetatable({
  ALL = ALL_MODES
}, {
  __index = function(_, key)
    return modes[key]
  end
})
