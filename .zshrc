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

if [[ -f ~/.extrarc ]]; then
  source ~/.extrarc
fi

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi
