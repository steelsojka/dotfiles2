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
        home-dir (vim.loop.os_homedir)
        root-dir (jdtls-setup.find_root ["gradlew" ".git"])
        workspace (string.format "%s/.local/share/eclipse/%s"
                                 home-dir
                                 (vim.fn.fnamemodify root-dir ":p:h:t"))
        gradle-home (.. root-dir "/gradle")
        config-name (if
                      (= (vim.fn.has :mac) 1) :mac
                      (= (vim.fn.has :unix) 1) :linux
                      (= (vim.fn.has :win32) 1) :win
                      "")]
    (jdtls.start_or_attach {:cmd ["jdtls" workspace gradle-home config-name]
                            :handlers lsp-config.handlers
                            :init_options
                            {:bundles (vim.list_extend
                                        [(vim.fn.glob
                                           (string.format
                                             "%s/src/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
                                             home-dir))]
                                        (vim.split (vim.fn.glob
                                                     (string.format "%s/src/vscode-java-test/server/*.jar" home-dir)) "\n"))}
                            :on_attach (fn [...]
                                         (lsp-config.on-attach ...)
                                         (jdtls-setup.add_commands)
                                         (jdtls.setup_dap))
                            :root_dir root-dir})
    (keymap.init-buffer-mappings {:t {:name "+test"}})
    (keymap.register-buffer-mappings
      {"n ca" {:do #(jdtls.code_action)}
       "v ca" {:do #(jdtls.code_action true)}
       "n ma" {:do #(dap-attach) :description "Attach to debugger"}
       "n mtc" {:do #(jdtls.test_class) :description "Test class"}
       "n mtm" {:do #(jdtls.test_nearest_method) :description "Test method"}
       "n mr" {:do #(jdtls.code_action false "refactor") :description "Refactor"}
       "n mo" {:do #(jdtls.organize_imports) :description "Organize imports"}
       "n mv" {:do #(jdtls.extract_variable) :description "Extract variable"}
       "v mv" {:do #(jdtls.extract_variable true) :description "Extract variable"}
       "v mm" {:do #(jdtls.extract_method true) :description "Extract method"}})))
