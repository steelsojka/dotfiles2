(module dotfiles.module.filetypes.dirvish
  {require {nvim aniseed.nvim
            fzf dotfiles.fzf
            keymap dotfiles.keymap}})

(def- find-fzf (fzf.create "Dirvish"))

(defn- fzf-dir [starting]
  (find-fzf.execute {:source (string.format "find \"%s\" -type d" starting)
                     :options ["--preview=ls la {}"]}))

(defn- fzf-files [starting]
  (-> (nvim.fn.fzf#vim#with_preview {:source (string.format "rg --hidden --files %s" starting)})
      (find-fzf.execute)))

(defn- create [input cmd expansion placeholder]
  (let [filehead (nvim.fn.expand expansion)
        name (nvim.fn.input input (if placeholder filehead ""))]
    (when (~= name "")
      (nvim.command (string.format cmd filehead name))
      (nvim.input "R"))))

(fn []
  (nvim.ex.setlocal "nospell")
  (keymap.init-buffer-mappings {:g {:name "+goto"}})
  (keymap.register-buffer-mappings
    {"n md" {:do #(create "Create directory: " "!mkdir %s/%s" "<cfile>:h")
             :description "Make directory"}
     "n mf" {:do #(create "Create file: " "!touch %s/%s" "<cfile>:h")
             :description "Create file"}
     "n mr" {:do #(let [filename (nvim.fn.expand "<cfile>:t")
                        filepath (nvim.fn.expand "<cfile>")
                        filehead (nvim.fn.expand "<cfile>:h")
                        new-name (nvim.fn.input "Rename file: " filename)]
                    (when (and (~= new-name "") (~= new-name filename))
                      (-> "!mv %s %s/%s"
                          (string.format filepath filehead new-name)
                          (nvim.command))
                      (nvim.input "R")))
            :description "Rename"}
     "n mm" {:do #(create "Move file to : " "!mv %s %s" "<cfile>" true)
             :description "Move"}
     "n mc" {:do #(create "Copy file to : " "!cp %s %s" "<cfile>" true)
             :description "Copy"}
     "n mk" {:do #(let [filepath (nvim.fn.expand "<cfile>")
                        confirmed (-> "Delete %s?"
                                      (string.format filepath)
                                      (nvim.fn.confirm))]
                    (when (= confirmed 1)
                      (-> "!rm -r %s"
                          (string.format filepath)
                          (nvim.command))
                      (nvim.input "R")))
             :description "Delete"}
     "n mgd" {:do #(-> (nvim.fn.expand "%:p:h") (fzf-dir)) :description "Child directory"}
     "n mgD" {:do #(-> (nvim.fn.getcwd) (fzf-dir)) :description "Project directory"}
     "n mgf" {:do #(-> (nvim.fn.expand "%:p:h") (fzf-files)) :description "Child file"}
     "n mgF" {:do #(-> (nvim.fn.getcwd) (fzf-files)) :description "Project file"}
     "nH" {:do "<Plug>(dirvish_up)"}
     "n q" {:do "gq" :noremap false}
     "n Q" {:do "gq" :noremap false}}))
