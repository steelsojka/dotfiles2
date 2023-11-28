(module dotfiles.module.modes)

(local modes (require "steelvim.modes"))

(defn- map-quit-bindings [include-q]
 (vim.keymap.set ["n" "v"] "Q" "<Cmd>quitall!<CR>" {:noremap true})
 (when include-q
   (vim.keymap.set ["n" "v"] "q" "<Cmd>quitall!<CR>" {:noremap true}))
 (vim.keymap.set ["n" "v"] "gq" "<Cmd>quitall!<CR>" {:noremap true})
 (vim.keymap.set ["n" "v"] "<leader>q" "<Cmd>quitall!<CR>" {:noremap true}))

(local mode-handlers
  {modes.GIT
   (fn []
     (let [neogit (require "neogit")]
       (map-quit-bindings true)
       (if vim.env.STEELVIM_GIT_CWD
         (neogit.open {:kind "replace" :cwd vim.env.STEELVIM_GIT_CWD})
         (neogit.open {:kind "replace" }))))
   modes.GIT_DIFF #(map-quit-bindings false)
   modes.GPT (fn []
               (vim.defer_fn
                 #(do
                   (vim.cmd "ChatGPT")
                   (map-quit-bindings true))
                 1))})

(when (not= vim.env.STEELVIM_MODE nil)
  (let [mode-fn (. mode-handlers vim.env.STEELVIM_MODE)]
    (when mode-fn (mode-fn))))
