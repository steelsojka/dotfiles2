(module dotfiles.funcref
  {require {nvim aniseed.nvim
            core aniseed.core
            rx dotfiles.rx
            util dotfiles.util}})

(global __LUA_FUNCTION_REFS
  (setmetatable (or __LUA_FUNCTION_REFS {}) {:__index (fn [tbl key]
                               (or (rawget tbl key) util.noop))}))

(nvim.command "
  function! LuaFunctionRefHandler(name, ...)
    return luaeval(\"__LUA_FUNCTION_REFS[_A.name](unpack(_A.args))\", {'name': a:name, 'args': a:000})
  endfunction")

(defn- get-vim-ref-string [ref ...]
  (..
    (string.format "function(\"LuaFunctionRefHandler\", [%s])"
                   (table.concat [(.. "\"" ref.name "\"") ...] ","))))

(defn- get-lua-ref-string [ref]
  (string.format "__LUA_FUNCTION_REFS[\"%s\"]" ref.name))

(defn create [callback opts]
  "A factory for creating function refs in Lua"
  (let [ref {:subscription (rx.new-subscription #(tset __LUA_FUNCTION_REFS ref.name nil))
             :unsubscribe #(ref.subscription.unsubscribe)
             :get-vim-ref-string #(get-vim-ref-string ref $...)
             :get-lua-ref-string #(get-lua-ref-string ref)}
        {: name} (or opts {})]
    (set ref.name (.. (or name :k) (util.unique-id)))
    (tset __LUA_FUNCTION_REFS ref.name #(callback ref $...))
    ref))
