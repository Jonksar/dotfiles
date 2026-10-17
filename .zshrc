# Managed by ~/.dotfiles. Machine/private additions go in ~/.zshrc.local (from dotfiles-private).
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"
export EDITOR="vim"
export PYTHONDONTWRITEBYTECODE=true

alias vi='vim' v='vim' g='git' h='history' q='exit'
alias ll='ls -lah' l='ls' sl='ls'
alias ,gs='git status' ,pp='git pull && git push'

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
