(module dotfiles.module.filetypes.plantuml
  {require {keymap dotfiles.keymap}})

(fn []
  (keymap.register-buffer-mappings
    {"n mp" {:do "<Cmd>PlantumlOpen<CR>" :description "Preview UML"}
     "n ms" {:do ":PlantumlSave " :description "Save UML"}
     "n mS" {:do "<Cmd>PlantumlStop<CR>" :description "Stop watching"}}))
