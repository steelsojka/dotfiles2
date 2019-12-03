local mappings = require 'utils/mappings'

LUA_FILETYPE_HOOKS = {
  dirvish = require 'filetypes/dirvish',
  typescript = require 'filetypes/typescript',
  qf = require 'filetypes/qf',
  markdown = require 'filetypes/markdown',
  java = require 'filetypes/java'
}

local autocmds = {}

for filetype,fn in pairs(LUA_FILETYPE_HOOKS) do
  autocmds['LuaFiletypeHooks_' .. mappings.escape_keymap(filetype)] = {
    { 'FileType', filetype, ("lua LUA_FILETYPE_HOOKS[%q]()"):format(filetype) }
  }
end

mappings.create_augroups(autocmds)
