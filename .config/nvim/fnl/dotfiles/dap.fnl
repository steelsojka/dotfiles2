(module dotfiles.dap)

(defn java-attach [project-name]
  (let [dap (require "dap")]
    (dap.run {:type "java"
              :request "attach"
              :port 5005
              :hostName "127.0.0.1"
              :projectName project-name})))
