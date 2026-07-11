# Dotfiles

Personal config, maintained (on and off) since ~2011. Ruby/Rails + Docker workflow,
zsh + oh-my-zsh, vim, [mise](https://mise.jdx.dev) for language versions.

## Fresh machine

```sh
git clone git@github.com:aaronmiler/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./bootstrap.sh
```

Installs Xcode CLT, Homebrew, everything in the `Brewfile`, oh-my-zsh, symlinks
the dotfiles, and installs ruby/node via mise. Safe to rerun — each step skips
what's already in place.

## Just the dotfiles

```sh
./install.sh
```

Symlinks everything into `$HOME` (idempotent, no prompts). Rerun after adding a
new file to the repo.

## What's where

| File | Purpose |
|---|---|
| `zshrc` | Aliases, functions, PATH — the bulk of daily shortcuts |
| `miler.zsh-theme` | Prompt (git status, ruby/node versions on the right) |
| `Brewfile` | The system shape — curated, not dumped; edit to taste |
| `mise_config` | Global ruby/node versions (`~/.config/mise/config.toml`) |
| `vimrc` / `vim/` | Vim config; plugins via vim-plug (auto-installs itself) |
| `ghostty_config` | Terminal (`~/.config/ghostty/config`) |
| `gitconfig` / `gitignore` | Git config + global excludes |

## Conventions

- Everything is symlinked, so edits in the repo are live immediately (`rerc` reloads zsh).
- Language versions come from mise only — no rbenv/nvm, and no hand-rolled
  `RUBY_CONFIGURE_OPTS`-style build fixes in zshrc (they outlive their usefulness
  and start breaking installs).
- Vim registers and the system clipboard stay separate by design; `<Leader>p` /
  `<Leader>cp` are the explicit bridges.
