local nvim = require 'nvim'
local Fzf = require 'fzf/fzf'
local utils = require 'utils/utils'

local fzf_delete_buffer_handler = Fzf:create(function(ref, buffers)
  for __,v in pairs(buffers) do
    local buf = v:match('^%[([0-9]+)%]')

    if buf ~= nil then
      nvim.ex.bw(buf)
    end
  end
end, { handle_all = true })

local function get_listed_buffers()
  return utils.filter(nvim.fn.range(1, nvim.fn.bufnr('$')), function(val)
    return nvim.fn.buflisted(val) == 1 and nvim.fn.getbufvar(val, '&filetype') ~= 'qf'
  end)
end

local function format_buflist(buflist)
  return utils.map(buflist, function(buf)
    local name = nvim.fn.bufname(buf)
    local modified = nvim.fn.getbufvar(buf, '&modified') == 1 and ' [+]' or ''
    local readonly = nvim.fn.getbufvar(buf, '&modifiable') == 1 and '' or ' [RO]'

    name = #name == 0 and '[No Name]' or nvim.fn.fnamemodify(name, ':p:~:.')

    return ('[%s] %s\t%s'):format(buf, name, modified .. readonly)
  end)
end

local function delete_buffers_fzf()
  fzf_delete_buffer_handler:execute {
    source = format_buflist(get_listed_buffers()),
    options = { '--multi', '--prompt=Kill> ', '--nth=2' }
  }
end

return {
  delete_buffers_fzf = delete_buffers_fzf
}
