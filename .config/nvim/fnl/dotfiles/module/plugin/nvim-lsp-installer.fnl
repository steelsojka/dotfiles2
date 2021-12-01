(module dotfiles.module.plugin.nvim-lsp-installer
  {require {lsp-configs dotfiles.lsp.configs}})

(defn configure []
  (let [lsp-installer (require "nvim-lsp-installer")]
    (lsp-installer.on_server_ready
      (fn [server]
        (let [server-config (lsp-configs.get-config-for server.name server)]
          (server:setup server-config))))))
