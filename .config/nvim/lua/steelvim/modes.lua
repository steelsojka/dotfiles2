local modes = {
  MAN_PAGER = "man_pager",
  GIT_PAGER = "git_pager",
  GIT = "git",
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
