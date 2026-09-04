(module dotfiles.module.plugin.neogit)

(defn configure []
  (let [neogit (require "neogit")]
    (neogit.setup
      {:integrations
       {:diffview true}
       :mappings
       {:status
        {:q false}}})))
