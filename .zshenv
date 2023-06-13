# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{exports,path,extra,aliases,env,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

ulimit -f unlimited

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh
