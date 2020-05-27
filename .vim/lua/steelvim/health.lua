local M = {}

function M.check()
  vim.fn["health#report_start"]("Binaries")

  if not vim.fn.executable("lazygit") then
    vim.fn["health#report_error"]("lazygit is not installed", "Please install lazygit")
  else
    vim.fn["health#report_ok"]("lazygit")
  end
end

return M
