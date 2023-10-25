(module dotfiles.bootstrap
  {require {core aniseed.core
            util dotfiles.util
            workspace dotfiles.workspace}})

(require "dotfiles.module.commands")
(require "dotfiles.module.filetypes")
(require "dotfiles.module.modes")
(require "dotfiles.module.mappings")
