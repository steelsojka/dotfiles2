(module dotfiles.module.plugin.orgmode)

(defn configure []
  (let [orgmode (require "orgmode")
        data-dir (vim.fn.stdpath "data")
        org-files (.. data-dir "/org/**/*")
        default-notes (.. data-dir "/org/refile.org")]
    (orgmode.setup_ts_grammar)
    (orgmode.setup {:org_agenda_files [org-files]
                    :org_default_notes default-notes
                    :org_todo_keywords ["TODO" "WAITING" "INPROGRESS" "ONGOING" "|" "DONE" "HANDLED" "CANCELED"]})))
