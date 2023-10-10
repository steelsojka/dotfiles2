# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{exports,path,aliases,env,functions,extra_profile}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

ulimit -f unlimited

if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi
