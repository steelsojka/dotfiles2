(module dotfiles.module.filetypes
  {require {core aniseed.core
            util dotfiles.util
            keymap dotfiles.keymap}})

(global __LUA_FILETYPE_HOOKS {})

(def- autocmds {})

(core.run!
  (fn [path]
    (let [name (vim.fn.fnamemodify path ":t:r")]
      (tset __LUA_FILETYPE_HOOKS name (require (.. "dotfiles.module.filetypes." name)))
      (tset autocmds
            (.. "LuaFiletypeHooks_" (keymap.escape-keymap name))
            [["FileType" name (string.format "lua __LUA_FILETYPE_HOOKS[%q]()" name)]])))
  (util.glob (.. (vim.fn.stdpath :config) "/lua/dotfiles/module/filetypes/*.lua")))

(keymap.create-augroups autocmds)
