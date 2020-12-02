(module dotfiles.module.plugin.completion
  {require {nvim aniseed.nvim}})

(set nvim.g.completion_timer_cycle 200)
(set nvim.g.completion_sorting :none)
(set nvim.g.completion_matching_strategy_list [:exact :substring :fuzzy])
(set nvim.g.completion_enable_auto_signature 1)
(set nvim.g.completion_auto_change_source 1)
(set nvim.g.completion_enable_auto_hover 1)
(set nvim.g.completion_chain_complete_list {
  :default [
    {:complete_items [:lsp]}
    {:complete_items [:buffers]}]
  :lua [{:complete_items [:ts :buffers]}]
  :typescript [
    {:complete_items [:lsp]}
    {:complete_items [:ts: :buffers]}]
  :javascript [
    {:complete_items [:lsp]}
    {:complete_items [:ts :buffers]}]})
