local M = {}

local colors = {
  black = 30;
  red = 31;
  green = 32;
  yellow = 33;
  blue = 34;
  magenta = 35;
  cyan = 36;
}

function M.color(color, text)
  return string.char(27) .. "[" .. colors[color] .. "m" .. text .. string.char(27) .. "[m"
end

for color,code in pairs(colors) do
  M[color] = function(text) return M.color(color, text) end
end

return M
