(module dotfiles.module.filetypes.dirvish
  {require {keymap dotfiles.keymap}})

(local telescope (require "telescope.builtin"))
(local actions (require "telescope.actions"))

(defn- create [input cmd expansion placeholder]
  (let [filehead (vim.fn.expand expansion)]
    (vim.ui.input
      {:prompt input
       :default (if placeholder filehead "")}
      #(when (and $ (~= $ ""))
        (vim.cmd (string.format cmd filehead $))
        (vim.api.nvim_input "R")))))

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
    {"n md" {:do #(create "Create directory: " "!mkdir %s/%s" "<cfile>:h")
             :description "Make directory"}
     "n mf" {:do #(create "Create file: " "!touch %s/%s" "<cfile>:h")
             :description "Create file"}
     "n mr" {:do #(let [filename (vim.fn.expand "<cfile>:t")
                        filepath (vim.fn.expand "<cfile>")
                        filehead (vim.fn.expand "<cfile>:h")]
                    (vim.ui.input
                      {:prompt "Rename file: "
                       :default filename}
                      #(when (and (~= $ "") (~= $ filename))
                         (-> "!mv %s %s/%s"
                             (string.format filepath filehead $)
                             (vim.cmd))
                         (vim.api.nvim_input "R"))))
            :description "Rename"}
     "n mm" {:do #(create "Move file to : " "!mv %s %s" "<cfile>" true)
             :description "Move"}
     "n mc" {:do #(create "Copy file to : " "!cp %s %s" "<cfile>" true)
             :description "Copy"}
     "n mk" {:do #(let [filepath (vim.fn.expand "<cfile>")
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
