(module dotfiles.module.filetypes.java
  {require {nvim aniseed.nvim
            lsp-config dotfiles.lsp.configs
            keymap dotfiles.keymap
            dap-utils dotfiles.dap}})

(fn dap-attach []
  (let [project-name (vim.fn.input "Project Name: ")]
    (dap-utils.java-attach project-name)))

(fn []
  (set vim.bo.shiftwidth 2)
  (vim.cmd (string.format
             "command! -nargs=1 JavaAttach call luaeval(%q, %q)"
             "require('dotfiles.dap')['java-attach'](_A)"
             "<args>"))
  (let [jdtls (require "jdtls")
        jdtls-setup (require "jdtls.setup")
        home-dir (vim.loop.os_homedir)]
    (jdtls.start_or_attach {:cmd ["jdtls"]
                            :handlers lsp-config.handlers
                            :init_options
                            {:bundles [(vim.fn.glob
                                         (string.format "%s/src/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
                                                        home-dir))]}
                            :on_attach (fn [...]
                                         (lsp-config.on-attach ...)
                                         (jdtls-setup.add_commands)
                                         (jdtls.setup_dap))
                            :root_dir (jdtls-setup.find_root ["gradle.properties"
                                                              "pom.xml"])})
    (keymap.register-buffer-mappings
      {"n ca" {:do #(jdtls.code_action)}
       "v ca" {:do #(jdtls.code_action true)}
       "n ma" {:do #(dap-attach) :description "Attach to debugger"}
       "n mr" {:do #(jdtls.code_action false "refactor") :description "Refactor"}
       "n mo" {:do #(jdtls.organize_imports) :description "Organize imports"}
       "n mv" {:do #(jdtls.extract_variable) :description "Extract variable"}
       "v mv" {:do #(jdtls.extract_variable true) :description "Extract variable"}
       "v mm" {:do #(jdtls.extract_method true) :description "Extract method"}})))
