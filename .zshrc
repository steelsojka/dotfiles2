# Load the shell dotfiles, and then some:
#
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
plugins=(node npm chucknorris)

source $ZSH/oh-my-zsh.sh

# Dotfiles command for managing dotfiles
alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

# For some reason we have to load this after oh-my-zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$HOME/bin:$HOME/.local/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/stevensojka/.sdkman"
[[ -s "/Users/stevensojka/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/stevensojka/.sdkman/bin/sdkman-init.sh"

alias luamake=/Users/stevensojka/src/lua-language-server/3rd/luamake/luamake
