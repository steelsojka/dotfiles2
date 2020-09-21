(module dotfiles.util
  {require {nvim aniseed.nvim}})

(defn expand [path]
  (nvim.fn.expand path))

(defn glob [path]
  (nvim.fn.glob path true true true))

(defn exists? [path]
  (= (nvim.fn.filereadable path) 1))

(defn lua-file [path]
  (nvim.ex.luafile path))

(def config-path (nvim.fn.stdpath "config"))

(defn nnoremap [from to]
  (nvim.set_keymap
    :n
    (.. "<leader>" from)
    (.. ":" to "<cr>")
    {:noremap true}))

(var id 0)
(defn unique-id [] (set id (+ id 1)) id)
(defn noop [])
