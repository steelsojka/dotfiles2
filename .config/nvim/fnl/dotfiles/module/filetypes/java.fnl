(module dotfiles.module.filetypes.java
  {require {nvim aniseed.nvim
            lsp-config dotfiles.lsp.configs
            keymap dotfiles.keymap}})

(fn []
  (set vim.bo.shiftwidth 2)
  (let [jdtls (require "jdtls")
        jdtls-setup (require "jdtls.setup")]
    (jdtls.start_or_attach {:cmd ["jdtls"]
                            :handlers lsp-config.handlers
                            :on_attach (fn [...]
                                         (lsp-config.on-attach ...)
                                         (jdtls-setup.add_commands))
                            :root_dir (jdtls-setup.find_root ["gradle.properties"
                                                              "pom.xml"])})
    (keymap.register-buffer-mappings
      {"n ca" {:do #(jdtls.code_action)}
       "v ca" {:do #(jdtls.code_action true)}
       "n mr" {:do #(jdtls.code_action false "refactor") :description "Refactor"}
       "n mo" {:do #(jdtls.organize_imports) :description "Organize imports"}
       "n mv" {:do #(jdtls.extract_variable) :description "Extract variable"}
       "v mv" {:do #(jdtls.extract_variable true) :description "Extract variable"}
       "v mm" {:do #(jdtls.extract_method true) :description "Extract method"}})))
