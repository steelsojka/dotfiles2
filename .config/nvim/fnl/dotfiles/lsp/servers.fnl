(module dotfiles.lsp.servers
  {require {core aniseed.core}})

(def- servers
  {:css "npm install -g vscode-css-languageserver-bin"
   :typescript "npm install -g typescript-language-server"
   :vim "npm install -g vim-language-server"
   :yaml "npm install -g yaml-language-server"
   :htm "npm install -g vscode-html-languageserver-bin"
   :json "npm install -g vscode-json-languageserver"
   :angularls "npm install -g @angular/language-server"
   :diagnostic "npm install -g diagnostic-languageserver"})

(defn install [commands]
  (let [_commands (or commands servers)]
    (each [_ cmd (pairs servers)]
      (if (= (type cmd) :string)
        (vim.cmd (.. "!" cmd))
        (cmd)))))
