(module dotfiles.workspace
  {require {files dotfiles.files}})

(def- local-config-filename "steelvimrc.lua")

(defn get-workspace-root [path matcher]
  (let [path-parts (vim.split path "/")
        _matcher (or matcher #(vim.tbl_contains $1 ".git"))]
    (var result nil)
    (while (> (length path-parts) 0)
      (when (not result)
        (let [dir (table.concat path-parts "/")
              files (vim.fn.readdir dir)]
          (when (_matcher files dir)
            (set result dir))))
      (table.remove path-parts))
    result))

(defn create-workspace [path folder-name matcher]
  (let [root (or (get-workspace-root path matcher) (vim.fn.expand "~"))
        local-folder (.. root "/" (or folder-name ".local"))]
    (when (= (vim.fn.isdirectory local-folder) 0)
      (os.execute (.. "mkdir " local-folder)))
    local-folder))

(defn cd-to-root [path matcher]
  (let [new-path (or path (vim.fn.getcwd))
        root (get-workspace-root new-path matcher)]
    (when root (vim.cmd (string.format "cd %s" root)))))

(defn source-local-config [options?]
  (let [options (or options? {})
        config-paths (files.nearest
                      local-config-filename
                      (vim.fn.getcwd)
                      options)]
    (each [_ config-path (ipairs config-paths)]
      (when config-path (vim.cmd (string.format "source %s" config-path))))))

(defn get-current-relative-path []
  (let [full-path (vim.fn.expand "%:p")]
    (files.to-relative-path (vim.fn.getcwd) full-path)))
