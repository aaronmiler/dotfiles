#!/bin/bash
# Symlink dotfiles into $HOME. Idempotent — rerun anytime a file is added.
set -euo pipefail
cd "$(dirname "$0")"

for file in *; do
  case "$file" in
    README.md|LICENSE|Brewfile|bootstrap.sh|install.sh|miler.zsh-theme|ghostty_config|mise_config|claude) continue ;;
  esac
  echo "linking ~/.$file"
  ln -sfn "$PWD/$file" "$HOME/.$file"
done

echo "linking zsh theme"
mkdir -p "$HOME/.oh-my-zsh/themes"
ln -sfn "$PWD/miler.zsh-theme" "$HOME/.oh-my-zsh/themes/miler.zsh-theme"

echo "linking ghostty config"
mkdir -p "$HOME/.config/ghostty"
ln -sfn "$PWD/ghostty_config" "$HOME/.config/ghostty/config"

echo "linking mise config"
mkdir -p "$HOME/.config/mise"
ln -sfn "$PWD/mise_config" "$HOME/.config/mise/config.toml"

# Claude Code: shared instructions + skills; machine-specific rules stay local
echo "linking claude config"
mkdir -p "$HOME/.claude"
if [ -f "$HOME/.claude/CLAUDE.md" ] && [ ! -L "$HOME/.claude/CLAUDE.md" ]; then
  echo "  ~/.claude/CLAUDE.md exists — move machine-specific parts to ~/.claude/CLAUDE.local.md, delete it, then rerun"
else
  ln -sf "$PWD/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
fi
# Shared skills link in per-file so machine-local skills can live alongside them
mkdir -p "$HOME/.claude/skills"
for skill in claude/skills/*.md; do
  ln -sf "$PWD/$skill" "$HOME/.claude/skills/$(basename "$skill")"
done
touch "$HOME/.claude/CLAUDE.local.md"  # imported by CLAUDE.md; per-machine, not versioned

git config --global core.excludesfile "~/.gitignore"
echo "done"
