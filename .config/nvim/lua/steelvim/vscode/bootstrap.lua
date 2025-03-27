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
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', '<leader>,', ':')
vim.keymap.set('n', '<leader>pp', vsa 'workbench.action.showCommands')
vim.keymap.set('n', '<leader>pf', vsa 'workbench.action.quickOpen')
vim.keymap.set('n', '<leader>ph', vsa 'workbench.action.openRecent')
vim.keymap.set('n', '<leader>fs', vsa 'workbench.action.files.save')
vim.keymap.set('n', '<leader>fS', vsa 'workbench.action.files.saveAll')
vim.keymap.set('n', '<leader>ff', vsa 'editor.action.formatDocument')
vim.keymap.set('v', '<leader>ff', vsa 'editor.action.formatSelection')
vim.keymap.set('n', '<leader>fo', vsa 'workbench.files.action.showActiveFileInExplorer')
vim.keymap.set('n', '<leader>fO', vsa 'workbench.action.files.openFile')
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
vim.keymap.set('n', '<leader>tp', vsa 'workbench.action.togglePanel')
vim.keymap.set('n', '<leader>ts', vsa 'workbench.action.toggleSidebarVisibility')
vim.keymap.set('n', '<leader>tS', vsa 'workbench.action.toggleAuxiliaryBar')
vim.keymap.set('n', '<leader>vo', vsa 'workbench.panel.output.focus')
vim.keymap.set('n', '<leader>vp', vsa 'workbench.panel.markers.view.focus')
vim.keymap.set('n', '<leader>vP', vsa '~remote.forwardedPortsContainer')
vim.keymap.set('n', '<leader>vd', vsa 'workbench.panel.repl.view.focus')
vim.keymap.set('n', '<leader>vc', vsa 'workbench.panel.chat.view.copilot.focus')
vim.keymap.set('n', '<leader>vt', vsa 'workbench.action.quickOpenTerm')
vim.keymap.set('n', '<leader>vs', vsa 'workbench.view.search')
vim.keymap.set('n', '<leader>ve', vsa 'workbench.view.explorer')
vim.keymap.set('n', '<leader>vE', vsa 'workbench.view.extensions')
vim.keymap.set('n', '<leader>gg', vsa 'workbench.view.scm')
vim.keymap.set('n', '<leader>cr', vsa 'editor.action.rename')
vim.keymap.set('n', '<leader>cd', vsa 'editor.action.revealDefinition')
vim.keymap.set('n', '<leader>cl', vsa 'editor.action.commentLine')
vim.keymap.set('v', '<leader>cl', vsa 'editor.action.blockComment')
vim.keymap.set('n', '<leader>jk', vsa 'cursorPageUp')
vim.keymap.set('n', '<leader>jj', vsa 'cursorPageDown')
vim.keymap.set('n', '<leader>/s', vsa 'actions.find')
vim.keymap.set('n', '<leader>ac', vsa 'workbench.panel.chat.view.copilot.focus')
vim.keymap.set('n', '<leader>aaf', vsa 'github.copilot.chat.attachFile')
vim.keymap.set('n', '<leader>aas', vsa 'github.copilot.chat.attachSelection')
vim.keymap.set('n', '<leader>aat', vsa 'github.copilot.chat.attachTerminalSelection')
vim.keymap.set('n', '<leader>am', vsa 'github.copilot.openModelPicker')
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

