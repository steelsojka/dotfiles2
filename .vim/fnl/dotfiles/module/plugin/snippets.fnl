(module dotfiles.module.plugin.snippets)

(def- S (require :snippets))
(def- U (require "snippets.utils"))
(def- snippets S.snippets)
(def- indent U.match_indentation)

(set snippets.javascript {
  :desc (indent "describe('${1}', () => {
});")
  :when (indent "describe('when ${1}', () => {
});")
  :it (indent "it('${1}', () => {
});")})
(set snippets.typescript (vim.tbl_extend :force snippets.javascript {}))
(set snippets.lua {
  :req "local ${2:${1|S.v:match\"([^.()]+)[()]*$\"}} = require \"${1}\""})

(set S.snippets snippets)
(S.use_suggested_mappings)
