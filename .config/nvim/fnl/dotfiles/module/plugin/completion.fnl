(module dotfiles.module.plugin.completion
  {require {nvim aniseed.nvim}})

(set nvim.g.completion_timer_cycle 200)
(set nvim.g.completion_sorting :none)
(set nvim.g.completion_matching_strategy_list [:exact :substring])
(set nvim.g.completion_enable_auto_signature 1)
(set nvim.g.completion_auto_change_source 1)
(set nvim.g.completion_enable_auto_hover 1)
(set nvim.g.completion_trigger_keyword_length 3)
(set nvim.g.completion_chain_complete_list {
  :default [
    {:complete_items [:lsp]}
    {:complete_items [:buffers]}
    {:mode "<c-p>"}
    {:mode "<c-n>"}]})
