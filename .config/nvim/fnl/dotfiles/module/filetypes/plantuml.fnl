(module dotfiles.module.filetypes.plantuml
  {require {keymap dotfiles.keymap}})

(fn []
  (keymap.register-buffer-mappings
    {"mp" {:do "<Cmd>PlantumlOpen<CR>" :description "Preview UML"}
     "ms" {:do ":PlantumlSave " :description "Save UML"}
     "mS" {:do "<Cmd>PlantumlStop<CR>" :description "Stop watching"}}
    {:prefix "<leader>"}))
