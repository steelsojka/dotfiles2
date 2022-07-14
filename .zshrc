[-f ~/.bootstrap_rc ] && source ~/.bootstrap_rc

# Load the shell dotfiles, and then some:
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
plugins=(node npm chucknorris)

source $ZSH/oh-my-zsh.sh

# Dotfiles command for managing dotfiles
alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

# For some reason we have to load this after oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.path
