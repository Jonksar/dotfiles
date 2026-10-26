# Managed by ~/.dotfiles. Machine/private additions go in ~/.zshrc.local (from dotfiles-private).
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"      # needs a powerline/nerd font (Brewfile installs Meslo LG Nerd Font)
DEFAULT_USER=joonatan
plugins=(git)
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

export EDITOR="vim"
export PYTHONDONTWRITEBYTECODE=true

alias vi='vim' v='vim' g='git' h='history' q='exit'
alias ll='ls -lah' l='ls' sl='ls'
alias ,gs='git status' ,pp='git pull && git push'

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# nvm costs ~0.8s per shell, so load it on first use; until then the newest installed node is on PATH.
export NVM_DIR="$HOME/.nvm"
_nvm_node=("$NVM_DIR"/versions/node/*(N/nOn[1]))
(( $#_nvm_node )) && export PATH="$_nvm_node[1]/bin:$PATH"
unset _nvm_node
nvm() {
  unfunction nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm use --silent default >/dev/null 2>&1
  nvm "$@"
}
