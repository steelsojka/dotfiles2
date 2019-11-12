# Load the shell dotfiles, and then some:
#
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
plugins=(node npm chucknorris)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# Dotfiles command for managing dotfiles
alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

