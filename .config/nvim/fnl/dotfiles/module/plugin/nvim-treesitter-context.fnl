(module dotfiles.module.plugin.nvim-treesitter-context)

(defn configure []
   (let [context (require "treesitter-context")]
     (context.setup {:enable true})))
