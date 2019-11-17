let &l:makeprg = g:typescript_compiler_binary . ' ' . g:typescript_compiler_options . ' $*'

lua << EOF
require('mappings').register_buffer_mappings {
  ['n mc'] = { [[<Cmd>Make -p tsconfig.json<CR>]], description = 'Compile' },
}
EOF

