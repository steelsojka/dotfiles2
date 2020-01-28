local nvim = require 'nvim'
local mappings = require 'utils/mappings'
local jobs = require 'utils/jobs'

return function()
  nvim.bo.shiftwidth = 4

  mappings.register_buffer_mappings {
    ['n ff'] = { function() 
      local cmd = 'prettier --tab-width 4 --print-width 120 --use-tabs false --stdin --parser java'
      local buffer = nvim.win_get_buf(0)
      local buf_lines = nvim.fn.getbufline(buffer, 1, '$')

      jobs.job_start(cmd, buf_lines):subscribe({
        next = function(lines)
          nvim.buf_set_lines(buffer, 0, -1, false, lines)
        end
      })
    end }
  }
end
