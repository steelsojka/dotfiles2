setlocal nospell

lua << EOF
require('mappings').register_buffer_mappings {
  ['n md'] = { [[:!mkdir %]], description = 'Make directory' },
  ['n mf'] = { [[:!touch %]], description = 'Create file' },
  ['n mr'] = { [["9yy:!mv <c-r>9 %]], description = 'Rename' },
  ['n mc'] = { [["9yy:!cp <c-r>9 %]], description = 'Copy' },
  ['n mk'] = { [["9yy:!rm -r <c-r>9]], description = 'Delete' },
  ['nK'] = { [[<Plug>(dirvish_up)]], noremap = false },
  ['n q'] = { [[gq]], noremap = false },
  ['n Q'] = { [[gq]], noremap = false }
}
EOF
