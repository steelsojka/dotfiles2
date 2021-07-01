(module dotfiles.module.plugin.snippets)

(def- S (require :snippets))
(def- U (require "snippets.utils"))
(def- snippets S.snippets)
(def- indent U.match_indentation)

(set snippets.javascript
 {:describe (indent "describe('${1}', () => {\n});")
  :when (indent "describe('when ${1}', () => {\n});")
  :it (indent "it('should ${1}', () => {\n});")
  :after (indent "after(() => {\n});")
  :afterEach (indent "afterEach(() => {\n});")
  :before (indent "before(() => {\n});")
  :beforeEach (indent "beforeEach(() => {\n});")
  :import (indent "import { ${1} } from '${2}';")})

(set snippets.typescript
     (vim.tbl_extend
       :force
       snippets.javascript
        {:nginject (indent
                     (string.format "@Inject(${1}) private readonly ${1|S.v:gsub(%q, string.lower)}: $1" "^[A-Z]"))}))

(set snippets.typescriptreact (vim.tbl_extend :force {} snippets.typescript))
(set snippets.javascriptreact (vim.tbl_extend :force {} snippets.javascript))

(set snippets.lua {
  :req "local ${2:${1|S.v:match\"([^.()]+)[()]*$\"}} = require \"${1}\""})

(set S.snippets snippets)
(S.use_suggested_mappings)
