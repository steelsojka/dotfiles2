# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{exports,path,extra,aliases,env,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

ulimit -f unlimited

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NODE_EXTRA_CA_CERTS="$HOME/npm-sfdc-certs.pem"
