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
vim.keymap.set('n', '<leader>.', vsa 'workbench.action.quickOpenWithModes')
vim.keymap.set('n', '<leader>pf', vsa 'workbench.action.quickOpen')
vim.keymap.set('n', '<leader>ph', vsa 'workbench.action.openRecent')
vim.keymap.set('n', '<leader>fs', vsa 'workbench.action.files.save')
vim.keymap.set('n', '<leader>fS', vsa 'workbench.action.files.saveAll')
vim.keymap.set('n', '<leader>ff', vsa 'editor.action.formatDocument')
vim.keymap.set('v', '<leader>ff', vsa 'editor.action.formatSelection')
vim.keymap.set('n', '<leader>fo', vsa 'workbench.files.action.showActiveFileInExplorer')
vim.keymap.set('n', '<leader>fO', vsa 'workbench.action.files.openFile')
vim.keymap.set('n', '<leader>q', vsa 'workbench.action.closeActiveEditor')
vim.keymap.set('n', '<leader>Q', vsa 'workbench.action.closeEditorsInGroup')
vim.keymap.set('n', '<leader>bb', vsa 'workbench.action.quickOpenPreviousEditor')
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
vim.keymap.set('n', '<leader>ww', vsa 'workbench.action.switchWindow')
vim.keymap.set('n', '<leader>tf', vsa 'editor.fold')
vim.keymap.set('n', '<leader>tF', vsa 'editor.foldRecursively')
vim.keymap.set('n', '<leader>tp', vsa 'workbench.action.togglePanel')
vim.keymap.set('n', '<leader>ts', vsa 'workbench.action.toggleSidebarVisibility')
vim.keymap.set('n', '<leader>tS', vsa 'workbench.action.toggleAuxiliaryBar')
vim.keymap.set('n', '<leader>tt', vsa 'workbench.action.quickOpenTerm')
vim.keymap.set('n', '<leader>ta', vsa 'workbench.action.toggleAuxiliaryBar')
vim.keymap.set('n', '<leader>vo', vsa 'workbench.panel.output.focus')
vim.keymap.set('n', '<leader>vp', vsa 'workbench.panel.markers.view.focus')
vim.keymap.set('n', '<leader>vP', vsa '~remote.forwardedPortsContainer')
vim.keymap.set('n', '<leader>vd', vsa 'workbench.panel.repl.view.focus')
vim.keymap.set('n', '<leader>vr', vsa 'workbench.view.debug')
vim.keymap.set('n', '<leader>vc', vsa 'workbench.action.toggleAuxiliaryBar')
vim.keymap.set('n', '<leader>vt', vsa 'workbench.action.quickOpenTerm')
vim.keymap.set('n', '<leader>vs', vsa 'workbench.view.search')
vim.keymap.set('n', '<leader>ve', vsa 'workbench.view.explorer')
vim.keymap.set('n', '<leader>vE', vsa 'workbench.files.action.focusOpenEditorsView')
vim.keymap.set('n', '<leader>vx', vsa 'workbench.view.extensions')
vim.keymap.set('n', '<leader>gg', vsa 'workbench.view.scm')
vim.keymap.set('n', '<leader>gl', vsa 'git.viewHistory')
vim.keymap.set('n', '<leader>gfh', vsa 'git.viewFileHistory')
vim.keymap.set('n', '<leader>glh', vsa 'git.viewLineHistory')
vim.keymap.set('n', '<leader>cr', vsa 'editor.action.rename')
vim.keymap.set('n', '<leader>cd', vsa 'editor.action.revealDefinition')
vim.keymap.set('n', '<leader>cl', vsa 'editor.action.commentLine')
vim.keymap.set('v', '<leader>cl', vsa 'editor.action.blockComment')
vim.keymap.set('n', '<leader>jk', vsa 'cursorPageUp')
vim.keymap.set('n', '<leader>jj', vsa 'cursorPageDown')
vim.keymap.set('n', '<leader>/', vsa 'actions.find')

-- Hop bindings
vim.keymap.set('n', 'F', '<Cmd>HopChar2<CR>', { desc = 'Hop 2 chars' })
vim.keymap.set('n', 'f', '<Cmd>HopChar1<CR>', { desc = 'Hop 1 chars' })
vim.keymap.set('n', 's', '<Cmd>HopWord<CR>', { desc = 'Hop word' })
vim.keymap.set('n', 'S', '<Cmd>HopPattern<CR>', { desc = 'Hop pattern' })

-- AI bindings
if vim.env.VSCODE_VARIANT == 'cursor' then
  vim.keymap.set('n', '<leader>avc', vsa 'workbench.action.chat.openInSidebar')
  vim.keymap.set('n', '<leader>ave', vsa 'workbench.action.chat.openInEditor')
  vim.keymap.set('n', '<leader>avn', vsa 'workbench.action.chat.openInNewWindow')
  vim.keymap.set('n', '<leader>af', vsa 'aichat.addfilestochataction')
  vim.keymap.set('n', '<leader>as', vsa 'aichat.insertselectionintochat')
else
  vim.keymap.set('n', '<leader>ac', vsa 'workbench.panel.chat.view.copilot.focus')
  vim.keymap.set('n', '<leader>aaf', vsa 'github.copilot.chat.attachFile')
  vim.keymap.set('n', '<leader>aas', vsa 'github.copilot.chat.attachSelection')
  vim.keymap.set('n', '<leader>aat', vsa 'github.copilot.chat.attachTerminalSelection')
  vim.keymap.set('n', '<leader>am', vsa 'github.copilot.openModelPicker')
end

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

--- Mappings from nvim/fnl/dotfiles/module/mappings.fnl ---

-- Leader shortcuts
vim.keymap.set('n', '<leader><CR>', vsa 'editor.action.goToLocations') -- marks not available, closest match

-- File <leader>f
vim.keymap.set('n', '<leader>fr', vsa 'workbench.action.openRecent')
vim.keymap.set('n', '<leader>fu', vsa 'workbench.action.localHistory.restoreViaPicker')
vim.keymap.set('n', '<leader>fp', function() vim.cmd('echo expand("%:p")') end)
vim.keymap.set('n', '<leader>f/', vsa 'actions.find')

-- Buffer <leader>b
vim.keymap.set('n', '<leader>bp', vsa 'workbench.action.previousEditor')
vim.keymap.set('n', '<leader>bn', vsa 'workbench.action.nextEditor')
vim.keymap.set('n', '<leader>bf', vsa 'workbench.action.firstEditorInGroup')
vim.keymap.set('n', '<leader>bl', vsa 'workbench.action.lastEditorInGroup')
vim.keymap.set('n', '<leader>bd', vsa 'workbench.action.closeActiveEditor')
vim.keymap.set('n', '<leader>bk', vsa 'workbench.action.closeActiveEditor')
vim.keymap.set('n', '<leader>bY', 'ggyG')

-- Window <leader>w
vim.keymap.set('n', '<leader>wd', vsa 'workbench.action.closeActiveEditor')
vim.keymap.set('n', '<leader>wn', vsa 'workbench.action.newWindow')
vim.keymap.set('n', '<leader>wq', vsa 'workbench.action.closeActiveEditor')
vim.keymap.set('n', '<leader>wr', vsa 'workbench.action.evenEditorWidths')
vim.keymap.set('n', '<leader>wb=', vsa 'workbench.action.evenEditorWidths')
vim.keymap.set('n', '<leader>w=', vsa 'workbench.action.evenEditorWidths')
vim.keymap.set('n', '<leader>wF', vsa 'workbench.action.moveEditorToNewWindow')
vim.keymap.set('n', '<leader>wo', vsa 'workbench.action.nextEditor')

-- Project <leader>p
vim.keymap.set('n', '<leader>pt', vsa 'workbench.view.explorer')
vim.keymap.set('n', '<leader>pT', vsa 'workbench.view.explorer')
vim.keymap.set('n', '<leader>pq', vsa 'workbench.action.closeWindow')
vim.keymap.set('n', '<leader>pQ', vsa 'workbench.action.closeWindow')

-- Navigation <leader>j
vim.keymap.set('n', '<leader>jl', '$')
vim.keymap.set('n', '<leader>jh', '0')
vim.keymap.set('n', '<leader>jd', vsa 'editor.action.revealDefinition')
vim.keymap.set('n', '<leader>ji', vsa 'editor.action.goToImplementation')
vim.keymap.set('n', '<leader>jy', vsa 'editor.action.goToTypeDefinition')
vim.keymap.set('n', '<leader>js', vsa 'workbench.action.gotoSymbol')
vim.keymap.set('n', '<leader>jS', vsa 'workbench.action.showAllSymbols')
vim.keymap.set('n', '<leader>jr', vsa 'editor.action.goToReferences')
vim.keymap.set('n', '<leader>jep', vsa 'editor.action.marker.prev')
vim.keymap.set('n', '<leader>jen', vsa 'editor.action.marker.next')
vim.keymap.set('n', '<leader>jeN', vsa 'editor.action.marker.next')
vim.keymap.set('n', '<leader>jeP', vsa 'editor.action.marker.prev')
vim.keymap.set('n', '<leader>jqp', vsa 'editor.action.marker.prev')
vim.keymap.set('n', '<leader>jqn', vsa 'editor.action.marker.next')
vim.keymap.set('n', '<leader>jn', vsa 'workbench.action.navigateBack')
vim.keymap.set('n', '<leader>jp', vsa 'workbench.action.navigateForward')
vim.keymap.set('n', '<leader>jml', vsa 'editor.action.goToLocations')

-- Search <leader>s
vim.keymap.set('n', '<leader>si', vsa 'workbench.action.showAllSymbols')
vim.keymap.set('n', '<leader>so', vsa 'workbench.action.gotoSymbol')
vim.keymap.set('n', '<leader>sr', vsa 'workbench.action.replaceInFiles')
vim.keymap.set('n', '<leader>sR', vsa 'editor.action.startFindReplaceAction')

-- Local search <leader>/
vim.keymap.set('n', '<leader>/h', '<Cmd>noh<CR>')

-- Yank <leader>y
vim.keymap.set('n', '<leader>yfp', vsa 'copyFilePath')
vim.keymap.set('n', '<leader>yfn', vsa 'copyFilePath') -- filename
vim.keymap.set('n', '<leader>yfP', vsa 'copyFilePath')
vim.keymap.set('n', '<leader>yfN', vsa 'copyFilePath')
vim.keymap.set('n', '<leader>yfr', vsa 'copyRelativeFilePath')
vim.keymap.set('n', '<leader>yfR', vsa 'copyRelativeFilePath')
vim.keymap.set('n', '<leader>yy', '"+y')

-- Diagnostics <leader>x
vim.keymap.set('n', '<leader>xx', vsa 'workbench.actions.view.toggleProblems')
vim.keymap.set('n', '<leader>xw', vsa 'workbench.actions.view.problems')
vim.keymap.set('n', '<leader>xd', vsa 'workbench.actions.view.problems')

-- Code <leader>c
vim.keymap.set('n', '<leader>cD', vsa 'editor.action.goToReferences')
vim.keymap.set('n', '<leader>ck', vsa 'editor.action.showHover')
vim.keymap.set('n', '<leader>ce', vsa 'workbench.actions.view.problems')
vim.keymap.set('n', '<leader>cR', vsa 'workbench.action.reloadWindow')
vim.keymap.set('n', '<leader>cs', vsa 'editor.action.triggerParameterHints')
vim.keymap.set('n', '<leader>cj', vsa 'workbench.action.gotoSymbol')
vim.keymap.set('n', '<leader>cJ', vsa 'workbench.action.showAllSymbols')
vim.keymap.set('n', '<leader>ca', vsa 'editor.action.quickFix')
vim.keymap.set('n', '<leader>co', vsa 'outline.focus')
vim.keymap.set('n', '<leader>cO', vsa 'outline.focus')

-- Quickfix <leader>l
vim.keymap.set('n', '<leader>lk', vsa 'editor.action.marker.prev')
vim.keymap.set('n', '<leader>lj', vsa 'editor.action.marker.next')

-- Git <leader>g
vim.keymap.set('n', '<leader>gcu', vsa 'git.revertChange')
vim.keymap.set('n', '<leader>gcs', vsa 'git.stageChange')
vim.keymap.set('n', '<leader>gcn', vsa 'workbench.action.editor.nextChange')
vim.keymap.set('n', '<leader>gcp', vsa 'workbench.action.editor.previousChange')
vim.keymap.set('n', '<leader>gci', vsa 'editor.action.dirtydiff.next')
vim.keymap.set('n', '<leader>gcb', vsa 'git.blameStatusBarItem.copyContent')
vim.keymap.set('n', '<leader>gB', vsa 'git.checkout')
vim.keymap.set('n', '<leader>gs', vsa 'workbench.view.scm')
vim.keymap.set('n', '<leader>gd', vsa 'git.openChange')
vim.keymap.set('n', '<leader>gL', vsa 'git.viewFileHistory')
vim.keymap.set('n', '<leader>gb', vsa 'git.toggleBlameAnnotations')
vim.keymap.set('n', '<leader>gC', vsa 'git.viewHistory')
vim.keymap.set('n', '<leader>gF', vsa 'workbench.action.quickOpen')

-- Debug <leader>d
vim.keymap.set('n', '<leader>db', vsa 'editor.debug.action.toggleBreakpoint')
vim.keymap.set('n', '<leader>dc', vsa 'workbench.action.debug.continue')
vim.keymap.set('n', '<leader>ds', vsa 'workbench.action.debug.stepInto')
vim.keymap.set('n', '<leader>dS', vsa 'workbench.action.debug.stepOver')
vim.keymap.set('n', '<leader>dr', vsa 'workbench.debug.action.focusRepl')
vim.keymap.set('n', '<leader>dh', vsa 'editor.debug.action.showDebugHover')

-- Toggle <leader>t
vim.keymap.set('n', '<leader>tl', vsa 'editor.action.toggleLineNumbers')
vim.keymap.set('n', '<leader>tw', vsa 'editor.action.toggleWordWrap')
vim.keymap.set('n', '<leader>tc', vsa 'editor.action.toggleRenderWhitespace')

-- Help <leader>h
vim.keymap.set('n', '<leader>hk', vsa 'workbench.action.openGlobalKeybindings')
vim.keymap.set('n', '<leader>hp', vsa 'workbench.extensions.action.showInstalledExtensions')

-- Terminal <leader>wt
vim.keymap.set('n', '<leader>wtt', vsa 'workbench.action.createTerminalEditor')
vim.keymap.set('n', '<leader>wtv', vsa 'workbench.action.createTerminalEditorSide')

-- Non-leader
vim.keymap.set('n', 'K', vsa 'editor.action.showHover')
vim.keymap.set('n', 'gh', vsa 'editor.action.showHover')

-- Visual leader mappings
vim.keymap.set('v', '<leader>jl', '$')
vim.keymap.set('v', '<leader>jh', '0')
vim.keymap.set('v', '<leader>jk', vsa 'cursorPageUp')
vim.keymap.set('v', '<leader>jj', vsa 'cursorPageDown')
vim.keymap.set('v', '<leader>yy', '"+y')
vim.keymap.set('v', '<leader>sr', vsa 'workbench.action.findInFiles')
vim.keymap.set('v', '<leader>sS', vsa('workbench.action.findInFiles', function()
  return {
    args = {
      query = vim.fn.expand('<cword>'),
      triggerSearch = true
    }
  }
end))

-- Visual non-leader
vim.keymap.set('v', 'F', '<Cmd>HopChar2<CR>', { desc = 'Hop 2 chars' })
vim.keymap.set('v', 'f', '<Cmd>HopChar1<CR>', { desc = 'Hop 1 chars' })
vim.keymap.set('v', 's', '<Cmd>HopWord<CR>', { desc = 'Hop word' })
vim.keymap.set('v', 'S', '<Cmd>HopPattern<CR>', { desc = 'Hop pattern' })

