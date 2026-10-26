# dotfiles
Public config. Private agent config, skills and memory live in two companion repos:
- [Jonksar/dotfiles-private](https://github.com/Jonksar/dotfiles-private) → `~/.dotfiles-private` (Claude/Codex/Hermes/Hindsight config, Claude memory, secrets layout)
- [Jonksar/.skills](https://github.com/Jonksar/.skills) → `~/.skills`, linked into `~/.claude/skills`, `~/.codex/skills`, `~/.hermes/skills/shared`

# New machine
Add your SSH key to GitHub first (so the private repos can be cloned), then:
```
curl -fsSL https://raw.githubusercontent.com/Jonksar/dotfiles/master/install.sh | bash
```
`install.sh` is idempotent — re-run it any time to pick up changes. It:
1. clones this repo to `~/.dotfiles`
2. installs Homebrew and everything in `Brewfile` (CLI tools, desktop apps, AI coding agents)
3. installs oh-my-zsh, symlinks `.zshrc .bashrc .inputrc .gitconfig .vimrc .tmux.conf .tmuxinator` + vim templates
4. installs Vundle + vim plugins, tmux plugin manager
5. installs the Hindsight CLI and (interactively) wires Hindsight memory into the coding agents
6. clones and links `dotfiles-private` and `.skills`

# What's in Brewfile
| Tool | CLI | Desktop |
|------|-----|---------|
| Codex (OpenAI) | `codex` cask | `chatgpt` cask (Codex app lives inside ChatGPT) |
| Claude (Anthropic) | `claude-code` cask | `claude` cask |
| Hermes (Nous Research) | `hermes-agent` formula | `hermes-desktop` cask |
| Hindsight (agent memory) | `curl -fsSL https://hindsight.vectorize.io/get-cli \| bash` | — |

After install: `hermes memory setup` → choose "hindsight".

# Day to day
- Change a public dotfile: edit in `~/.dotfiles`, commit, push.
- Change agent config / memory: it's already written into `~/.dotfiles-private` via symlinks — `cd ~/.dotfiles-private && git add -A && git commit -m update && git push`.
- Add a skill: `~/.skills/<name>/SKILL.md`, commit, push.
- Machine-specific shell bits: `~/.zshrc.local` (private repo), sourced by `.zshrc`.
- Node in zsh: the newest Node version installed under `~/.nvm/versions/node` is added to PATH so `node` and `npm` work without loading nvm. The first `nvm` call loads nvm and its completion, selects the default alias, then runs the requested command. Until that call, Node uses the newest installed version rather than the default alias.

# Linux
`install.sh` installs git/zsh/tmux/vim/node via apt and the Codex, Claude Code and Hermes CLIs via their installers. No desktop apps.
