# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{exports,path,aliases,env,functions,extrarc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

source ~/.bash_prompt
ulimit -f unlimited

if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi
