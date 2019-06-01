# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,extra,env}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

ulimit -n 65536

# Set name of the theme to load.
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

bindkey "jj" vi-cmd-mode

plugins=(git node npm vi-mode chucknorris)

source $ZSH/oh-my-zsh.sh

alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc

# And enter the dragon...
chuck_cow
