lua require "aniseed.env".init({module = "dotfiles"})

inoremap <silent><expr> <CR> compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
