(module dotfiles.workspace
  {require {nvim aniseed.nvim
            files dotfiles.files}})

(def- local-config-filename "steelvimrc.lua")

(defn get-workspace-root [path matcher]
  (let [path-parts (vim.split path "/")
        _matcher (or matcher (fn [file] (= file ".git")))]
    (var result nil)
    (while (> (length path-parts) 0)
      (let [dir (table.concat path-parts "/")
            files (nvim.fn.readdir dir)]
        (each [_ file (ipairs files)]
          (when (and (not result) (_matcher file files dir))
            (set result dir)))
        (table.remove path-parts)))
    result))

(defn create-workspace [path folder-name matcher]
  (let [root (or (get-workspace-root path matcher) (nvim.fn.expand "~"))
        local-folder (.. root "/" (or folder-name ".local"))]
    (when (= (nvim.fn.isdirectory local-folder) 0)
      (os.execute (.. "mkdir " local-folder)))
    local-folder))

(defn cd-to-root [path matcher]
  (let [new-path (or path (nvim.fn.getcwd))
        root (get-workspace-root new-path matcher)]
    (when root (nvim.ex.cd root))))

(defn source-local-config []
  (let [config-path (files.nearest
                      local-config-filename
                      (vim.fn.getcwd))]
    (when config-path (nvim.ex.source config-path))))
