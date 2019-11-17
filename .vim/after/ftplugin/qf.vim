lua << EOF
require('mappings').register_buffer_mappings {
  ['n mn'] = { [[:cnewer<CR>]], description = 'Newer list' },
  ['n mp'] = { [[:colder<CR>]], description = 'Older list'  },
  ['n ml'] = { [[:chistory<CR>]], description = 'List history' },
  ['n mf'] = { [[:call steelvim#filter_qf(0)<CR>]], description = 'Filter (destructive)' },
  ['n mF'] = { [[:call steelvim#filter_qf(1)<CR>]], description = 'Filter' },
  ['n md'] = { [[:call steelvim#delete_qf_items(bufnr())<CR>]], description = 'Delete item' },
  ['v md'] = { [[:call steelvim#delete_qf_items(bufnr())<CR>]], description = 'Delete selected items' }
}
EOF
