(module dotfiles.lib)

(setmetatable
  {}
  {:__index #(require (string.gsub $2 "_" "."))})
