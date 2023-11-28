local modes = {
  -- "man ls"
  MAN_PAGER = "man_pager",
  -- "git log"
  GIT_PAGER = "git_pager",
  -- General GIT viewing. Replaces lazygit.
  GIT = "git",
  -- "git diff"
  GIT_DIFF = "git_diff",
  -- "gpt"
  GPT = "gpt"
}

local ALL_MODES = vim.tbl_values(modes)

local function mixin_mode(tbl, mode_tbl)
  local mixin = mode_tbl[vim.env.STEELVIM_MODE]

  if type(mixin) == "table" then
    return vim.tbl_extend("force", tbl, mixin)
  elseif type(mixin) == "function" then
    local result = mixin(tbl)

    return result or tbl
  end

  return tbl
end

return setmetatable({
  ALL = ALL_MODES,
  mixin_mode = mixin_mode
}, {
  __index = function(_, key)
    return modes[key]
  end
})
