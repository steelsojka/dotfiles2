local sysname = vim.loop.os_uname().sysname
local is_mac_os = sysname == "Darwin"

return {
  is_mac_os = is_mac_os,
  is_linux = not is_mac_os
}
