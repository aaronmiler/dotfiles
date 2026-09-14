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
| `ghostty_themes/` | `Trillium Dark` / `Trillium Light` — see [Trillium](#trillium-terminal--vim-theme) below |
| `gitconfig` / `gitignore` | Git config + global excludes |
| `claude/` | Claude Code global instructions (`CLAUDE.md` → `~/.claude`) |
| `doug/` | doug global instructions (`DOUG.md` → `~/.doug`); profile/settings/auth stay local |
| `agent_skills/` | Shared skill files (rails/frontend/testing), symlinked into both `~/.claude/skills` and `~/.doug/skills` |

## Conventions

- Everything is symlinked, so edits in the repo are live immediately (`rerc` reloads zsh).
- Language versions come from mise only — no rbenv/nvm, and no hand-rolled
  `RUBY_CONFIGURE_OPTS`-style build fixes in zshrc (they outlive their usefulness
  and start breaking installs).
- Vim registers and the system clipboard stay separate by design; `<Leader>p` /
  `<Leader>cp` are the explicit bridges.
- Claude Code config is split: `claude/CLAUDE.md` is the shared base and imports
  `~/.claude/CLAUDE.local.md` for per-machine rules (homelab here, work conventions
  at work). `settings.json` is deliberately not versioned — its env block can hold
  API keys.
- `agent_skills/` is one core set of skill files shared across agents: `install.sh`
  symlinks each into both `~/.claude/skills` and `~/.doug/skills`. They carry
  `name`/`description` frontmatter (doug's loader requires it; harmless to Claude's
  path references). Linked per-file, so machine-local skills (cascadia, tars) live
  alongside them unversioned. doug auto-loads `~/.doug/skills` — no settings change
  needed.

## Trillium (terminal + vim theme)

Named for Trillium Lake, near Mt. Hood. Solarized-style naming (`Trillium Dark` /
`Trillium Light`, one family, a dark/light suffix) but not a Solarized reskin:
bolder, PNW-specific hues, held to the same readability bar. Every foreground
color is checked against WCAG AA (4.5:1) on its own background — comments and
doc prose included, not just headline text.

- `ghostty_themes/Trillium Dark` / `Trillium Light` — full 16-slot ANSI palette plus
  background/foreground/cursor/selection, wired up via `theme = dark:...,light:...`
  in `ghostty_config`.
- `vim/colors/trillium.vim` — cterm-only, no `termguicolors`, same technique the old
  `vim-colors-solarized` setup used: highlight groups reference ANSI slot numbers,
  not hex, so vim's colors always match whichever Ghostty theme is active. Branches
  on `&background`.
- Trillium Dark is the daily driver. Trillium Light is the deliberate fallback for
  glare (bright rooms, outdoor light, spring/summer) — its contrast is pushed
  higher, not just a flat inversion of the dark variant.

| Role | Trillium Dark | Trillium Light |
|---|---|---|
| background | `#16212a` | `#f1efe4` |
| foreground | `#d8d9c8` | `#2c3530` |
| comment / dim | `#7c8f86` (4.8:1) | `#5c6b62` (4.9:1) |
| red | `#e0725a` | `#b8402a` |
| green | `#8fbf6f` | `#34702f` |
| yellow | `#e3b34d` | `#7d5f0f` |
| blue | `#6fa8c9` | `#29698f` |
| purple | `#b48ddb` | `#7a4f9e` |
| teal / cyan | `#57c2b3` | `#12786b` |

Known limitation: ANSI 16-color has no dedicated "orange" slot. Ruby instance
variables fall back to bright red (`ctermfg=9`) in vim — close, not identical to
early mockups that had orange to spare.
