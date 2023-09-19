(module dotfiles.keymap
  {require {nvim aniseed.nvim
            core aniseed.core
            util dotfiles.util}})

(global __LUA_BUFFER_MAPPINGS {})
(global __LUA_AUGROUP_HOOKS {})

(defn unimplemented [] (print "Unimplemented mapping!"))

(defn escape-keymap [key]
  (.. "k" (string.gsub key "." string.byte)))

(defn- normalize-mapping [mapping]
  (if (= (type mapping) "string")
    mapping
    {1 (or mapping.do (. mapping 1))
     2 mapping.description
     :name mapping.name
     :silent mapping.silent
     :buffer mapping.buffer
     :expr mapping.expr
     :nowait mapping.nowait
     :mode mapping.mode}))

(defn- normalize-mappings [mappings]
  (let [result {}]
    (each [binding mapping (pairs mappings)]
      (tset result binding (normalize-mapping mapping)))
    result))

(defn register-mappings [mappings options]
  (let [which-key (require "which-key")
        normalized-mappings (normalize-mappings mappings)]
    (which-key.register normalized-mappings options)))

(defn register-buffer-mappings [mappings default-options buffer?]
  (let [buffer (or buffer (vim.api.nvim_get_current_buf))
        opts (or default-options {})]
    (register-mappings
      mappings
      (vim.tbl_extend "keep" {: buffer} opts))))

(defn create-autocmd [cmddef name]
  (var definition cmddef)
  (local cmd-name (or name (.. "Lua_autocmd_" (util.unique-id))))
  (when (= (type (. cmddef (length cmddef))) :function)
    (local _fn (. cmddef (length cmddef)))
    (set definition [(unpack definition 1 (- (length cmddef) 1))])
    (table.insert definition (string.format "lua __LUA_AUGROUP_HOOKS['%s']()" cmd-name))
    (tset __LUA_AUGROUP_HOOKS cmd-name _fn))
  (nvim.command (table.concat (vim.tbl_flatten ["autocmd" definition]) " ")))

(defn create-autocmds [defs]
  (each [_ cmddef (ipairs defs)] (create-autocmd cmddef)))

(defn create-augroups [definitions]
  (each [group-name defs (pairs definitions)]
    (nvim.command (.. "augroup LuaAugroup_" group-name))
    (nvim.command "autocmd!")
    (each [index cmddef (ipairs defs)]
      (create-autocmd cmddef (.. group-name index)))
    (nvim.command "augroup END")))
