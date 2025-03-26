local code = require "vscode";

vim.notify = code.notify

local function vsa(action, opts)
  return function()
    if type(opts) == 'function' then
      opts = opts()
    end

    code.action(action, opts)
  end
end

vim.keymap.set('n', 'U', '<C-r>') -- Redo
vim.keymap.set('n', '<leader>pp', vsa 'workbench.action.showCommands')
vim.keymap.set('n', '<leader>pf', vsa 'workbench.action.quickOpen')
vim.keymap.set('n', '<leader>ph', vsa 'workbench.action.openRecent')
vim.keymap.set('n', '<leader>fs', vsa 'workbench.action.files.save')
vim.keymap.set('n', '<leader>fS', vsa 'workbench.action.files.saveAll')
vim.keymap.set('n', '<leader>ff', vsa 'editor.action.formatDocument')
vim.keymap.set('v', '<leader>ff', vsa 'editor.action.formatSelection')
vim.keymap.set('n', '<leader>fo', vsa 'workbench.files.action.showActiveFileInExplorer')
vim.keymap.set('n', '<leader>q', vsa 'workbench.action.closeActiveEditor')
vim.keymap.set('n', '<leader>Q', vsa 'workbench.action.closeAllEditors')
vim.keymap.set('n', '<leader>bb', vsa 'workbench.action.quickOpenPreviousEditor')
vim.keymap.set('n', '<leader>wtt', vsa 'workbench.action.quickOpenTerm')
vim.keymap.set('n', '<leader>ws', vsa 'workbench.action.splitEditorDown')
vim.keymap.set('n', '<leader>wv', vsa 'workbench.action.splitEditorRight')
vim.keymap.set('n', '<leader>wh', vsa 'workbench.action.navigateLeft')
vim.keymap.set('n', '<leader>wj', vsa 'workbench.action.navigateDown')
vim.keymap.set('n', '<leader>wl', vsa 'workbench.action.navigateRight')
vim.keymap.set('n', '<leader>wk', vsa 'workbench.action.navigateUp')
vim.keymap.set('n', '<leader>wH', vsa 'workbench.action.moveEditorToLeftGroup')
vim.keymap.set('n', '<leader>wJ', vsa 'workbench.action.moveEditorToBelowGroup')
vim.keymap.set('n', '<leader>wL', vsa 'workbench.action.moveEditorToRightGroup')
vim.keymap.set('n', '<leader>wK', vsa 'workbench.action.moveEditorToAboveGroup')
vim.keymap.set('n', '<leader>tf', vsa 'editor.fold')
vim.keymap.set('n', '<leader>tF', vsa 'editor.foldRecursively')
vim.keymap.set('n', '<leader>cr', vsa 'editor.action.rename')
vim.keymap.set('n', '<leader>cd', vsa 'editor.action.revealDefinition')
vim.keymap.set('n', '<leader>cl', vsa 'editor.action.commentLine')
vim.keymap.set('v', '<leader>cl', vsa 'editor.action.blockComment')
vim.keymap.set('n', '<leader>jk', vsa 'cursorPageUp')
vim.keymap.set('n', '<leader>jj', vsa 'cursorPageDown')
vim.keymap.set('n', '<leader>/s', vsa 'actions.find')
vim.keymap.set('n', '<leader>sp', vsa('workbench.action.findInFiles', function()
  return { args = { isRegex = true } }
end))
vim.keymap.set('n', '<leader>sb', vsa('workbench.action.findInFiles', function()
  return { args = { isRegex = true, onlyOpenEditors = true } }
end))
vim.keymap.set('n', '<leader>ss', vsa 'workbench.action.findInFiles')
vim.keymap.set('n', '<leader>sS', vsa('workbench.action.findInFiles', function()
  return {
    args = {
      query = vim.fn.expand('<cword>'),
      triggerSearch = true
    }
  }
end))

