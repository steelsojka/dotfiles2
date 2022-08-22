(module dotfiles.module.filetypes.dirvish
  {require {keymap dotfiles.keymap}})

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

(defn- get-file-under-cursor []
  (let [directory (get-directory)
        line (vim.fn.line ".")
        file-name (vim.fn.expand "<cfile>:t")]
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
  (keymap.init-buffer-mappings {:g {:name "+goto"}})
  (keymap.register-buffer-mappings
    {"n md" {:do #(create "Create directory: " "!mkdir %s/%s" (get-directory))
             :description "Make directory"}
     "n mf" {:do #(create "Create file: " "!touch %s/%s" (get-directory))
             :description "Create file"}
     "n mr" {:do #(let [filename (vim.fn.expand "<cfile>:t")
                        filepath (get-file-under-cursor)
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
     "n mm" {:do #(create "Move file to : " "!mv %s %s" (get-file-under-cursor) true)
             :description "Move"}
     "n mc" {:do #(create "Copy file to : " "!cp %s %s" (get-file-under-cursor) true)
             :description "Copy"}
     "n mk" {:do #(let [filepath (get-file-under-cursor)
                        confirmed (-> "Delete %s?"
                                      (string.format filepath)
                                      (vim.fn.confirm))]
                    (when (= confirmed 1)
                      (-> "!rm -r %s"
                          (string.format filepath)
                          (vim.cmd))
                      (vim.api.nvim_input "R")))
             :description "Delete"}
     "n mgf" {:do #(-> {:cwd (vim.fn.expand "%:p:h")} (telescope.find_files)) :description "Child file"}
     "n mgF" {:do #(-> (vim.fn.getcwd) (find-files)) :description "Project file"}
     "nH" {:do "<Plug>(dirvish_up)"}
     "n q" {:do "<Plug>(dirvish_quit)" }
     "n Q" {:do "<Plug>(dirvish_quit)" }}))
