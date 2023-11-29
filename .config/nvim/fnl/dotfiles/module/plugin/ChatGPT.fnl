(module dotfiles.module.plugin.ChatGPT)

(defn configure []
  (let [gpt (require "chatgpt")]
    (gpt.setup
      {:chat
       {:keymaps
        {:yank_last "<leader>myy"
         :close "<leader>q"
         :yank_last_code "<leader>myk"
         :scroll_up "<C-k>"
         :scroll_down "<C-d>"
         :new_session "<leader>msn"
         :cycle_windows "<leader>mw"
         :cycle_modes "<leader>mM"
         :next_message "<leader>mmn"
         :prev_message "<leader>mmp"
         :select_session "<leader>mss"
         :rename_session "<leader>msr"
         :delete_session "<leader>msd"
         :draft_message "<leader>mmd"
         :edit_message "<leader>mme"
         :delete_message "<leader>mmD"
         :toggle_settings "<leader>mts"
         :toggle_message_role "<leader>mtr"
         :toggle_system_role_open "<leader>mtR"
         :stop_generating "<leader>mK"}}
       :edit_with_instructions
       {:keymaps
        {:close "<leader>q"
         :accept "<leader>m<CR>"
         :toggle_diff "<leader>mtd"
         :toggle_settings "<leader>mts"
         :cycle_windows "<leader>mw"
         :use_output_as_input "<leader>mi"}}})))
