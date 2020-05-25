return function()
  vim.bo.makeprg = ('%s %s $*'):format(vim.g.typescript_compiler_binary, vim.g.typescript_compiler_options)

  steel.mappings.register_buffer_mappings {
    ['n mc'] = { [[<Cmd>Make -p tsconfig.json<CR>]], description = 'Compile' },
  }
end
