(module dotfiles.module.plugin.startify)

(defn setup []
  (set vim.g.startify_lists
       [{:type "dir" :header [(.. "   MRU " (vim.fn.getcwd))]}
        {:type "sessions" :header ["   Sessions"]}])
  (set vim.g.startify_update_oldfiles 1)
  (set vim.g.startify_session_sort 1)
  (set vim.g.startify_change_to_vcs_root 1)
  (set vim.g.startify_custom_header [
    "                                 __                 "
    "    ___      __    ___   __  __ /\\_\\    ___ ___     "
    "  /' _ `\\  /'__`\\ / __`\\/\\ \\/\\ \\\\/\\ \\ /' __` __`\\   "
    "  /\\ \\/\\ \\/\\  __//\\ \\_\\ \\ \\ \\_/ |\\ \\ \\/\\ \\/\\ \\/\\ \\  "
    "  \\ \\_\\ \\_\\ \\____\\ \\____/\\ \\___/  \\ \\_\\ \\_\\ \\_\\ \\_\\ "
    "   \\/_/\\/_/\\/____/\\/___/  \\/__/    \\/_/\\/_/\\/_/\\/_/ "
    "                                      Steel Edition "]))
