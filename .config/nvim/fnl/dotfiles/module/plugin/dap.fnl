(module dotfiles.module.plugin.dap)

(defn configure []
  (let [dap (require "dap")
        adapters dap.adapters
        configurations dap.configurations]
    (set adapters.kotlin
         {:type "executable"
          :command "kotlin-debug-adapter"
          :args []})
    (set configurations.kotlin
         {:type "kotlin"
          :request "attach"
          :port 8000
          :name "Kotlin Attach"
          :timeout 30000
          :projectRoot (vim.fn.getcwd)
          :hostName "localhost"})))
