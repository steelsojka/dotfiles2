(module dotfiles.module.modes)

(local modes
  {:git
   (fn []
     (let [neogit (require "neogit")]
       (vim.keymap.set ["n" "v"] "Q" "<Cmd>quitall!<CR>" {:noremap true})
       (vim.keymap.set ["n" "v"] "q" "<Cmd>quitall!<CR>" {:noremap true})
       (vim.keymap.set ["n" "v"] "<leader>q" "<Cmd>quitall!<CR>" {:noremap true})
       (if vim.env.STEELVIM_GIT_CWD
         (neogit.open {:kind "replace" :cwd vim.env.STEELVIM_GIT_CWD})
         (neogit.open {:kind "replace" }))))})

(when (not= vim.env.STEELVIM_MODE nil)
  (let [mode-fn (. modes vim.env.STEELVIM_MODE)]
    (when mode-fn (mode-fn))))
