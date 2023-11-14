(module dotfiles.module.plugin.nvim-spectre)

(fn map-leader-mappings [value]
  "Map all leader mappings to g"
  (let [is-leader (string.find value.map "<leader>")]
    (if is-leader
      (vim.tbl_extend "keep"
                      {:map (string.gsub value.map "<leader>" "g")}
                      value)
      value)))

(defn configure []
  (let [spectre (require "spectre")
        spectre-config (require "spectre.config")
        mappings (vim.tbl_map map-leader-mappings spectre-config.mapping)]
    (spectre.setup
      {:mapping mappings})))

