local nvim = require 'nvim'
local mappings = require 'mappings'

mappings.create_augroups {
  float_term = {
    { 'VimResized', '*', function() 
      nvim.g.floaterm_width = nvim.fn.float2nr(nvim.o.columns * 0.9)
      nvim.g.floaterm_height = nvim.fn.float2nr(nvim.o.lines * 0.75)
    end}
  },

  terminal = {
    { 'TermOpen', '*', function() 
      nvim.ex.setlocal('nospell', 'nonumber')
    end}
  },

  startify = {
    { 'User', 'Startified', function()
      nvim.ex.setlocal('buflisted')
    end}
  }
}
