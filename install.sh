#!/bin/bash
# Idempotent setup for a new machine. Re-run any time.
#   curl -fsSL https://raw.githubusercontent.com/Jonksar/dotfiles/master/install.sh | bash
set -u
DOTFILES_DIR="$HOME/.dotfiles"
PRIVATE_DIR="$HOME/.dotfiles-private"
PRIVATE_REPO="git@github.com:Jonksar/dotfiles-private.git"

have() { command -v "$1" >/dev/null 2>&1; }
clone_if_missing() { [ -d "$2" ] || git clone -q "$1" "$2"; }
link() { # link $DOTFILES_DIR/$1 -> $HOME/$1 (or into $2) if the source exists
  local src="$DOTFILES_DIR/$1" dst="${2:-$HOME}/$(basename "$1")"
  [ -e "$src" ] || return 0
  [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ] && return 0
  [ -e "$dst" ] && [ ! -L "$dst" ] && mv "$dst" "$dst.pre-dotfiles"
  ln -sfnv "$src" "$dst"
}

# 0. Get the repo itself (so the curl|bash one-liner works)
have git || { echo "git is required"; exit 1; }
clone_if_missing https://github.com/Jonksar/dotfiles.git "$DOTFILES_DIR"

# 1. Packages
if [ "$(uname)" == "Darwin" ]; then
    echo "==> macOS packages"
    if ! have brew; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    brew bundle --no-upgrade --file "$DOTFILES_DIR/Brewfile"
elif [ "$(uname -s)" == "Linux" ]; then
    echo "==> Linux packages"
    sudo apt install -y git zsh tmux vim curl nodejs npm
    npm install -g @openai/codex                                        # Codex CLI
    curl -fsSL https://claude.ai/install.sh | bash                      # Claude Code CLI
    curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash  # Hermes Agent CLI
else
    echo "Unsupported OS: $(uname -s)"; exit 1
fi

# 2. Shell
echo "==> oh-my-zsh"
clone_if_missing https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

# 3. Dotfiles
echo "==> symlinks"
for f in .zshrc .bashrc .inputrc .gitconfig .vimrc .tmux.conf .tmuxinator; do link "$f"; done
mkdir -p "$HOME/.vim/templates"
link .ycm_extra_conf.py "$HOME/.vim"
link .vim/templates/c_template.txt "$HOME/.vim/templates"
link .vim/templates/py_template.txt "$HOME/.vim/templates"

# 4. Vim + tmux plugins
echo "==> vim/tmux plugins"
clone_if_missing https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
vim -E -s -u "$HOME/.vimrc" +PluginInstall +qall </dev/null >/dev/null 2>&1 || true
clone_if_missing https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# 5. Agentic tooling
echo "==> Hindsight"
have hindsight || [ -x "$HOME/.local/bin/hindsight" ] || curl -fsSL https://hindsight.vectorize.io/get-cli | bash
if [ ! -f "$HOME/.hindsight/coding-agent.json" ] && [ -t 0 ]; then
    # Wires memory into Claude Code / Codex / ...; asks where memory lives (cloud / daemon / self-hosted).
    npx -y @vectorize-io/hindsight-coding-agents install all
fi
if have hermes && [ ! -d "$HOME/.hermes/plugins/hindsight" ]; then
    hermes plugins install hindsight   # then: hermes memory setup -> "hindsight"
fi

# 6. Private config (agent settings, skills, memory) — needs a GitHub SSH key on this machine
echo "==> private dotfiles"
if ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    clone_if_missing "$PRIVATE_REPO" "$PRIVATE_DIR"
    "$PRIVATE_DIR/install.sh"
    # Shared agent skills (github.com/Jonksar/.skills): one checkout, linked into every agent
    clone_if_missing git@github.com:Jonksar/.skills.git "$HOME/.skills"
    mkdir -p "$HOME/.claude" "$HOME/.codex" "$HOME/.hermes/skills"
    for d in "$HOME/.claude/skills" "$HOME/.codex/skills" "$HOME/.hermes/skills/shared"; do
        [ -L "$d" ] || { [ -e "$d" ] && mv "$d" "$d.pre-dotfiles"; ln -sfnv "$HOME/.skills" "$d"; }
    done
else
    echo "No GitHub SSH access; skipped. Add your SSH key to GitHub, then:"
    echo "  git clone $PRIVATE_REPO $PRIVATE_DIR && $PRIVATE_DIR/install.sh"
fi

echo "==> done. Open a new shell, or: exec zsh"
