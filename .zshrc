export ANTIDOTE_HOME=$HOME/.antidote

autoload -Uz compinit && compinit

if (( $+commands[git] )); then
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
  alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
fi

if [[ -f "${ANTIDOTE_ZSH_SCRIPT}" ]]; then
  source "${ANTIDOTE_ZSH_SCRIPT}"
  antidote load
fi

if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

if [[ -f "${HOME}/.extrarc" ]]; then
  source $HOME/.extrarc
fi

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# >>> aisuite >>>
export NODE_EXTRA_CA_CERTS="/Users/ssojka/.aisuite/conf/npm-sfdc-certs.pem"
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) [ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH" ;;
esac
export PATH="/Users/ssojka/.aisuite/bin:/Users/ssojka/.aisuite/bin/aliases:$PATH"
# <<< aisuite <<<
