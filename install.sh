#!/bin/bash
# Symlink dotfiles into $HOME. Idempotent — rerun anytime a file is added.
set -euo pipefail
cd "$(dirname "$0")"

for file in *; do
  case "$file" in
    README.md|LICENSE|Brewfile|bootstrap.sh|install.sh|miler.zsh-theme|ghostty_config|mise_config|claude|doug|agent_skills) continue ;;
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
touch "$HOME/.claude/CLAUDE.local.md"  # imported by CLAUDE.md; per-machine, not versioned

# doug: shared global instructions; profile/settings/auth stay machine-local
echo "linking doug config"
mkdir -p "$HOME/.doug"
ln -sf "$PWD/doug/DOUG.md" "$HOME/.doug/DOUG.md"

# Shared agent skills: one core set feeds both Claude and doug. Linked per-file
# so machine-local skills (cascadia, tars, ...) can live alongside them unversioned.
# doug auto-loads ~/.doug/skills; Claude reads them via CLAUDE.md path references.
echo "linking shared agent skills"
mkdir -p "$HOME/.claude/skills" "$HOME/.doug/skills"
for skill in agent_skills/*.md; do
  base="$(basename "$skill")"
  ln -sf "$PWD/$skill" "$HOME/.claude/skills/$base"
  ln -sf "$PWD/$skill" "$HOME/.doug/skills/$base"
done

git config --global core.excludesfile "~/.gitignore"
echo "done"
