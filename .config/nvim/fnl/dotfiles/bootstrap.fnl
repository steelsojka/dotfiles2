(module dotfiles.bootstrap
  {require {core aniseed.core
            util dotfiles.util
            workspace dotfiles.workspace}})

;; Load all modules in no particular order.
(->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
     (core.run! (fn [path]
                  (require (string.gsub path ".*/(.-)/(.-)/(.-)%.lua" "%1.%2.%3")))))

(workspace.source-local-config)
