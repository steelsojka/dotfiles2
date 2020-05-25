__LUA_FILETYPE_HOOKS = {
  dirvish = require 'steelvim/filetypes/dirvish',
  typescript = require 'steelvim/filetypes/typescript',
  qf = require 'steelvim/filetypes/qf',
  markdown = require 'steelvim/filetypes/markdown',
  java = require 'steelvim/filetypes/java',
  lua = require 'steelvim/filetypes/lua'
}

local autocmds = {}

for filetype,fn in pairs(__LUA_FILETYPE_HOOKS) do
  autocmds['LuaFiletypeHooks_' .. steel.mappings.escape_keymap(filetype)] = {
    { 'FileType', filetype, ("lua __LUA_FILETYPE_HOOKS[%q]()"):format(filetype) }
  }
end

steel.mappings.create_augroups(autocmds)
