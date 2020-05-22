local mappings = require 'steelvim/utils/mappings'

return function()
  mappings.register_buffer_mappings {
    ['n mp'] = { [[<Plug>MarkdownPreview]], noremap = false, description = "Preview" }
  }
end
