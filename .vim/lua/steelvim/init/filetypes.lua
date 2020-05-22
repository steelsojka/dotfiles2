local mappings = require 'steelvim/utils/mappings'

LUA_FILETYPE_HOOKS = {
  dirvish = require 'steelvim/filetypes/dirvish',
  typescript = require 'steelvim/filetypes/typescript',
  qf = require 'steelvim/filetypes/qf',
  markdown = require 'steelvim/filetypes/markdown',
  java = require 'steelvim/filetypes/java',
  lua = require 'steelvim/filetypes/lua'
}

local autocmds = {}

for filetype,fn in pairs(LUA_FILETYPE_HOOKS) do
  autocmds['LuaFiletypeHooks_' .. mappings.escape_keymap(filetype)] = {
    { 'FileType', filetype, ("lua LUA_FILETYPE_HOOKS[%q]()"):format(filetype) }
  }
end

mappings.create_augroups(autocmds)
