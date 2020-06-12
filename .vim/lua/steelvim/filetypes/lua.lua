local api = vim.api

return function()
  vim.bo.shiftwidth = 2

  api.nvim_buf_set_keymap(0, "n", " cr", ":call completion_treesitter#smart_rename()<CR>", { noremap = true })
end
