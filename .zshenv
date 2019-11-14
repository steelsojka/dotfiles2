# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,extra,aliases,env,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

ulimit -n 65533

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

hash fzf=~/.fzf/bin/fzf

[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh
