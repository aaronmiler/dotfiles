#!/bin/bash
# Fresh-machine setup: install the system shape (Brewfile), then link dotfiles.
# Safe to rerun — every step skips what's already in place.
set -euo pipefail
cd "$(dirname "$0")"

# Xcode Command Line Tools (git, compilers — brew needs these)
if ! xcode-select -p &> /dev/null; then
  xcode-select --install
  echo "Finish the Command Line Tools install, then rerun ./bootstrap.sh"
  exit 1
fi

# Homebrew
if [ ! -x /opt/homebrew/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# System shape — edit Brewfile to taste
brew bundle --file=Brewfile

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Dotfile symlinks (after omz + brew so the theme and mise config have homes)
./install.sh

# Language runtimes from the freshly linked global mise config
mise install

echo
echo "Bootstrapped. Remaining manual steps:"
echo "  - ssh-keygen -t ed25519   (then add the public key to GitHub)"
echo "  - open a new terminal (or: exec zsh)"
