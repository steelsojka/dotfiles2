(module dotfiles.keymap
  {require {nvim aniseed.nvim
            core aniseed.core
            util dotfiles.util}})

(global __LUA_BUFFER_MAPPINGS {})
(global __LUA_AUGROUP_HOOKS {})

(defn unimplemented [] (print "Unimplemented mapping!"))

(defn escape-keymap [key]
  (.. "k" (string.gsub key "." string.byte)))

(defn- strip-plus [name]
  (if (= (string.sub name 1 1) "+")
    (string.sub name 2)
    name))

(defn- normalize-mapping [binding mapping prefix]
  (let [key (.. (or prefix "") binding)]
    (if (= (type mapping) "string")
      (let [entry [key]]
        (tset entry :desc mapping)
        entry)
      (and mapping.name (not mapping.do) (not (. mapping 1)))
      (let [entry [key]]
        (tset entry :group (strip-plus mapping.name))
        entry)
      (let [lhs (or mapping.do (. mapping 1))
            entry [key lhs]]
        (tset entry :desc mapping.description)
        (tset entry :silent mapping.silent)
        (tset entry :buffer mapping.buffer)
        (tset entry :expr mapping.expr)
        (tset entry :nowait mapping.nowait)
        (tset entry :mode mapping.mode)
        entry))))

(defn- normalize-mappings [mappings options]
  (let [result {}
        prefix (and options options.prefix)
        mode (and options options.mode)
        buffer (and options options.buffer)]
    (each [binding mapping (pairs mappings)]
      (table.insert result (normalize-mapping binding mapping prefix)))
    (when mode (tset result :mode mode))
    (when buffer (tset result :buffer buffer))
    result))

(defn register-mappings [mappings options]
  (let [which-key (util.safe-require "which-key")
        normalized-mappings (normalize-mappings mappings options)]
    (when which-key
      (which-key.add [normalized-mappings]))))

(defn register-buffer-mappings [mappings default-options buffer?]
  (let [buffer (or buffer? (vim.api.nvim_get_current_buf))
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
