# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,functions,extrarc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

source ~/.bash_prompt

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
