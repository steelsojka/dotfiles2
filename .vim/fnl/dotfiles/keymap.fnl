(module dotfiles.keymap
  {require {nvim aniseed.nvim
            core aniseed.core
            util dotfiles.util}})

(global __LUA_MAPPINGS {})
(global __LUA_BUFFER_MAPPINGS {})
(global __LUA_AUGROUP_HOOKS {})

(defn unimplemented [] (print "Unimplemented mapping!"))

(defn escape-keymap [key]
  (.. "k" (string.gsub key "." string.byte)))

(defn init-buffer-mappings [mappings]
  (let [(_ val-or-err) (pcall #nvim.b.local_which_key)]
    (var result val-or-err)
    (when (~= (type val-or-err) :table)
      (set result {:m (or mappings {})}))
    (set nvim.b.local_which_key result)
    result))

(defn parse-key-map [keystring]
  (local result [])
  (var i 1)
  (local len (length keystring))
  (var is-meta false)
  (var char-result "")
  (var key-index 1)
  (while (<= i len)
    (local char (string.sub keystring i i))
    (match [is-meta char]
      [false "<"] (do
                    (set is-meta true)
                    (set char-result "<"))
      [true ">"] (do
                   (set is-meta false)
                   (tset result key-index (.. char-result ">"))
                   (set key-index (+ key-index 1))
                   (set char-result ""))
      [true] (set char-result (.. char-result char))
      _ (do
          (tset result key-index char)
          (set key-index (+ key-index 1))
          (set char-result "")))
    (set i (+ i 1)))
  result)

(defn add-to-which-key [keys description dict]
  (let [category-keys [(unpack keys 1 (- (length keys) 1))]
        end-key (. keys (length keys))
        category (core.reduce #(. $1 $2) dict category-keys)]
    (tset category end-key description)))

(defn register-mapping [key mapping dict]
  (local (mode key-string) (string.match key "^(.)(.+)$"))
  (local keys (parse-key-map key-string))
  (var action mapping.do)
  (local is-buffer (or
                     (= mapping.buffer true)
                     (= (type mapping.buffer) :number)))
  (local bufnr (or
                 (and
                   (= (type mapping.buffer) :number)
                   mapping.buffer)
                 (nvim.get_current_buf)))
  (when (and (= (. keys 1) " ") (~= mapping.which-key false) mapping.description)
    (if (and (= (. keys 2) "m") is-buffer)
      (do
        (local local-wk-dict (init-buffer-mappings))
        (add-to-which-key [(unpack keys 2)] mapping.description local-wk-dict)
        (set nvim.b.local_which_key local-wk-dict))
      dict
      (add-to-which-key [(unpack keys 2)] mapping.description dict)))
  (set mapping.do nil)
  (set mapping.description nil)
  (set mapping.which-key nil)
  (set mapping.buffer nil)
  (local escaped-key (escape-keymap (.. mode key-string)))
  (if (= (type action) :function)
    (do
      (if is-buffer
        (do
          (when (not (. __LUA_BUFFER_MAPPINGS bufnr))
            (tset __LUA_BUFFER_MAPPINGS bufnr {})
            (nvim.buf_attach bufnr false {:on_detach #(tset __LUA_BUFFER_MAPPINGS bufnr nil)}))
          (tset (. __LUA_BUFFER_MAPPINGS bufnr) escaped-key action)
          (if (or (= mode "v") (= mode "x"))
            (set action (string.format ":<C-u>lua __LUA_BUFFER_MAPPINGS[%d]['%s']()<CR>"
                                       bufnr
                                       escaped-key))
            (set action (string.format "<Cmd>lua __LUA_BUFFER_MAPPINGS[%d]['%s']()<CR>"
                                       bufnr
                                       escaped-key))))
        (do
          (tset __LUA_MAPPINGS escaped-key action)
          (if (or (= mode "v") (= mode "x"))
            (set action (string.format ":<C-u>lua __LUA_MAPPINGS['%s']()<CR>" escaped-key))
            (set action (string.format "<Cmd>lua __LUA_MAPPINGS['%s']()<CR>" escaped-key)))))
      (set mapping.noremap true)
      (set mapping.silent true))
    (= (type action) :string)
    (when (string.match (string.lower action) "^<plug>")
      (set mapping.noremap false)))
  (if is-buffer
    (nvim.buf_set_keymap bufnr mode key-string action mapping)
    (nvim.set_keymap mode key-string action mapping)))

(defn register-mappings [mappings default-options wk-dict]
  (each [keys mapping (pairs mappings)]
    (register-mapping keys (vim.tbl_extend :keep mapping (or default-options {})) wk-dict)))

(defn register-buffer-mappings [mappings default-options buffer]
  (each [keys mapping (pairs mappings)]
    (register-mapping keys (vim.tbl_extend :keep
                                           {:buffer (or buffer true)}
                                           mapping
                                           (or default-options {})))))

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
