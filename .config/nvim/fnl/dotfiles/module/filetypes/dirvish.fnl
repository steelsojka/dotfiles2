(module dotfiles.module.filetypes.dirvish
  {require {keymap dotfiles.keymap
            utils dotfiles.util}})

(local telescope (require "telescope.builtin"))
(local actions (require "telescope.actions"))

(defn- create [input cmd filepath placeholder]
  (vim.ui.input
    {:prompt input
     :default (if placeholder filepath "")}
    #(when (and $ (~= $ ""))
      (print (string.format cmd filepath $))
      (vim.cmd (string.format cmd filepath $))
      (vim.api.nvim_input "R"))))

(defn- get-directory []
  (let [directory (vim.fn.expand "%")]
    (string.match directory "(.-)/$")))

(defn- get-path-tail [path]
  (let [parts (utils.split path "/")
        tail (utils.tail parts)]
    tail))

(defn- get-file-under-cursor []
  (let [directory (get-directory)
        file-path (vim.fn.expand "<cfile>")
        file-name (get-path-tail file-path)]
    (string.format "%s/%s" directory file-name)))

(defn- find-files [cwd]
  (telescope.find_files
    {: cwd
     :attach_mappings (fn []
                        (actions._goto_file_selection:replace
                          #(let [entry (actions.get_selected_entry)]
                             (vim.cmd (string.format "Dirvish %s" (. entry 1)))
                             (vim.cmd "stopinsert")))
                        true)}))

(fn []
  (vim.cmd "setlocal nospell")
  (keymap.register-buffer-mappings
    {"<leader>md" {:do #(create "Create directory: " "!mkdir %s/%s" (get-directory))
             :description "Make directory"}
     "<leader>mf" {:do #(create "Create file: " "!touch %s/%s" (get-directory))
             :description "Create file"}
     "<leader>mr" {:do #(let [filepath (get-file-under-cursor)
                        filename (get-path-tail filepath)
                        filehead (get-directory)]
                    (vim.ui.input
                      {:prompt "Rename file: "
                       :default filename}
                      #(when (and (~= $ "") (~= $ filename))
                         (-> "!mv %s %s/%s"
                             (string.format filepath filehead $)
                             (vim.cmd))
                         (vim.api.nvim_input "R"))))
            :description "Rename"}
     "<leader>mm" {:do #(create "Move file to : " "!mv %s %s" (get-file-under-cursor) true)
             :description "Move"}
     "<leader>mc" {:do #(create "Copy file to : " "!cp -R %s %s" (get-file-under-cursor) true)
             :description "Copy"}
     "<leader>mk" {:do #(let [filepath (get-file-under-cursor)
                        confirmed (-> "Delete %s?"
                                      (string.format filepath)
                                      (vim.fn.confirm))]
                    (when (= confirmed 1)
                      (-> "!safe-rm -r %s"
                          (string.format filepath)
                          (vim.cmd))
                      (vim.api.nvim_input "R")))
             :description "Delete"}
     "<leader>mgf" {:do #(-> {:cwd (vim.fn.expand "%:p:h")} (telescope.find_files)) :description "Child file"}
     "<leader>mgF" {:do #(-> (vim.fn.getcwd) (find-files)) :description "Project file"}
     "H" {:do "<Plug>(dirvish_up)" :description "Up"}
     "<leader>q" {:do "<Plug>(dirvish_quit)" :description "Quit"}
     "<leader>Q" {:do "<Plug>(dirvish_quit)" :description "Quit"}}))
