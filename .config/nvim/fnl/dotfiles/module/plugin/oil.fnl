(module dotfiles.module.plugin.oil)

(defn configure []
  (let [oil (require "oil")]
    (oil.setup {
     :columns ["permissions"
               "size"
               "icon"]
     :keymaps {
      "g?" "actions.show_help"
      "<CR>" "actions.select"
      "<C-s>" "actions.select_vsplit"
      "<C-h>" "actions.select_split"
      "<C-t>" "actions.select_tab"
      "<C-p>" "actions.preview"
      "q" "actions.close"
      "<leader>q" "actions.close"
      "R" "actions.refresh"
      "H" "actions.parent"
      "_" "actions.open_cwd"
      "`" "actions.cd"
      "~" "actions.tcd"
      "gs" "actions.change_sort"
      "gx" "actions.open_external"
      "g." "actions.toggle_hidden"}})))
