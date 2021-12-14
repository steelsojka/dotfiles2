(module dotfiles.module.plugin.plantuml-previewer)

(defn setup []
  (let [home-dir (vim.loop.os_homedir)
        jar-path (string.format "%s/lib/plantuml/plantuml.jar" home-dir)]
    (print jar-path)
    (set vim.g.plantuml_previewer#plantuml_jar_path jar-path)))
