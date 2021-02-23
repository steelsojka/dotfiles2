(module dotfiles.sessions)

(fn get-default-session-name []
  (string.gsub (vim.fn.getcwd) "/" "_"))

(defn save-session [name is-new]
  (if is-new
    (vim.cmd "SSave")
    (let [name (or name (get-default-session-name))]
      (vim.cmd (.. "SSave! " name)))))

(defn load-session [load-default]
  (if load-default
    (let [confirmed (vim.fn.confirm "Load default session?" "&Yes\n&No" 2)]
      (when (= confirmed 1)
        (vim.cmd (.. "SLoad" (get-default-session-name)))))
    (vim.cmd "SLoad")))

(defn delete-session [default]
  (if default
    (let [confirmed (vim.fn.confirm "Delete default session?" "&Yes\n&No" 2)]
      (when (= confirmed 1)
        (vim.cmd (.. "SDelete" (get-default-session-name)))))
    (vim.cmd "SDelete")))
