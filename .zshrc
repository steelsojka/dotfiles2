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

# For some reason we have to load this after oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/soj214/.sdkman"
[[ -s "/Users/soj214/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/soj214/.sdkman/bin/sdkman-init.sh"
