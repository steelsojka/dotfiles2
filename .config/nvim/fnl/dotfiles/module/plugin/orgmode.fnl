(module dotfiles.module.plugin.orgmode)

(defn configure []
  (let [orgmode (require "orgmode")
        org-files "~/.orgmode/**/*"
        default-notes "~/.orgmode/refile.org"]
    (orgmode.setup {:org_agenda_files [org-files]
                    :org_default_notes_file default-notes
                    :org_todo_keywords ["TODO" "WAITING" "INPROGRESS" "ONGOING" "|" "DONE" "HANDLED" "CANCELED"]})))
