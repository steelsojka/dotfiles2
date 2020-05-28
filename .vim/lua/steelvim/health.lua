local M = {}

function M.check()
  vim.fn["health#report_start"]("Binaries")

  if vim.fn.executable("lazygit") == 1 then
    vim.fn["health#report_ok"]("lazygit")
  else
    vim.fn["health#report_error"]("lazygit is not installed", "Please install lazygit")
  end

  if vim.fn.executable("node") == 1 then
    vim.fn["health#report_ok"]("node")
  else
    vim.fn["health#report_error"]("NodeJS is not installed", "Please install it")
  end
end

return M
