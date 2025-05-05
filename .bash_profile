for file in ~/.{exports,path,aliases,env,functions,extra,extra_profile}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

ulimit -f unlimited

eval "$(/opt/homebrew/bin/brew shellenv)"
