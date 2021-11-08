(module dotfiles.module.plugin.pears)

(let [pears (require "pears")
      cmp (require "cmp")
      confirm (cmp.mapping.confirm {:select true})]
  (pears.setup (fn [conf]
                 ; (conf.preset "tag_matching")
                 (conf.on_enter (fn [handler]
                                  (if (and (= (vim.fn.pumvisible) 1) (not= (. (vim.fn.complete_info) "selected") -1))
                                    (confirm "<CR>")
                                    (handler)))))))
