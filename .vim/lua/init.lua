local nvim = require 'nvim'
local colorizer = require 'colorizer'

nvim.ex.filetype('plugin', 'indent', 'on')
nvim.ex.syntax('on')

require 'init/settings'
require 'init/globals'
require 'init/global_mappings'
require 'init/filetypes'
require 'init/commands'

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

