#!/bin/bash
# Symlink dotfiles into $HOME. Idempotent — rerun anytime a file is added.
set -euo pipefail
cd "$(dirname "$0")"

for file in *; do
  case "$file" in
    README.md|LICENSE|Brewfile|bootstrap.sh|install.sh|miler.zsh-theme|ghostty_config|mise_config) continue ;;
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

git config --global core.excludesfile "~/.gitignore"
echo "done"
