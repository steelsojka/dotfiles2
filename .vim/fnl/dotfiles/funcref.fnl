(module dotfiles.funcref
  {require {nvim aniseed.nvim
            core aniseed.core
            util dotfiles.util}})

(global __LUA_FUNCTION_REFS
  (setmetatable (or __LUA_FUNCTION_REFS {}) {:__index (fn [tbl key]
                               (or (rawget tbl key) util.noop))}))

(vim.command "
  function! LuaFunctionRefHandler(name, ...)
    return luaeval(\"__LUA_FUNCTION_REFS[_A.name](unpack(_A.args))\", {'name': a:name, 'args': a:000})
  endfunction")

(defn- unsubscribe [])
(defn- get-vim-ref-string [ref ...]
  (..
    (string.format "function(\"LuaFunctionRefHandler\", [%s])"
                   (core.join [(.. "\"" ref.name "\"") ...] ","))))

(defn create [callback opts]
  (let [ref {:unsubscribe (fn [...] (unsubscribe ref ...))
             :get-vim-ref-string (fn [...] (get-vim-ref-string ref ...))}
        {: name} (or opts {})]
    (set ref.name (.. (or name :k) (util.unique-id)))
    (tset __LUA_FUNCTION_REFS ref.name (fn [...] (callback ref ...)))))
