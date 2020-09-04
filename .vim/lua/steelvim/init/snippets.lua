local S = require "snippets"
local U = require "snippets.utils"

local snippets = S.snippets
local indent = U.match_indentation

snippets.javascript = {
  desc = indent [[
describe('${1}', () => {
});
  ]],
  when = indent [[
describe('when ${1}', () => {
});
  ]],
  it = indent [[
it('${1}', () => {
});
  ]]
}

snippets.typescript = vim.tbl_extend("force", snippets.javascript, {

})

snippets.lua = {
  req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require "${1}"]]
}

S.snippets = snippets
