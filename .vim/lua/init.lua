local nvim = require 'nvim'
local colorizer = require 'colorizer'

require 'steelvim'

nvim.ex.filetype('plugin', 'indent', 'on')
nvim.ex.syntax('on')

require 'settings'
require 'globals'
require 'global_mappings'
require 'filetypes'

colorizer.setup {
  'css',
  'sass',
  'less',
  'typescript',
  'javascript',
  'vim',
  'html',
  'jst',
  'lua'
}

