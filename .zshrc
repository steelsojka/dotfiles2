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

if [[ -f "${HOME}/.extrarc" ]]; then
  source $HOME/.extrarc
fi

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

if (( $+commands[fzf] )); then
  source <(fzf --zsh)
  # zsh-vi-mode defers its init to the first precmd and rebinds Ctrl+R to
  # history-incremental-search-backward, clobbering fzf. Re-source fzf after
  # zvm finishes so fzf-history-widget wins.
  zvm_after_init_commands+=('source <(fzf --zsh)')
fi

# devbar-managed-start
export NODE_EXTRA_CA_CERTS="$HOME/.devbar/certs/corporate-ca-bundle.pem"
# devbar-managed-end

# >>> aisuite >>>
export NODE_EXTRA_CA_CERTS="/Users/ssojka/.aisuite/conf/npm-sfdc-certs.pem"
export PATH="$PATH:/Users/ssojka/.aisuite/bin:/Users/ssojka/.aisuite/bin/aliases"
# <<< aisuite <<<
