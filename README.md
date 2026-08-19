# enpitsulin's dotfiles

Managed with [chezmoi](https://www.chezmoi.io/). Supports **macOS** and **Linux** (zsh on both).

## Prerequisites

- [chezmoi](https://www.chezmoi.io/install/)
- [starship](https://starship.rs/guide/#%F0%9F%8D%B0-installation)
- [mise](https://mise.jdx.dev/getting-started.html)

## Quick start

```sh
# One-shot install and apply
chezmoi init --apply https://github.com/enpitsulin/dotfiles.git
```

On a fresh machine, `chezmoi apply` also runs the platform bootstrap script
(`run_once_bootstrap.sh.tmpl`, rendered per-platform), which installs
Homebrew (macOS) or system packages (Linux), mise, starship, and the platform
JDK. A fresh login shell is required afterwards.

## Daily usage

```sh
# Pull latest changes and apply
chezmoi update

# Edit a managed file
chezmoi edit ~/.zshrc

# Apply changes (after editing outside chezmoi)
chezmoi apply

# See what would change
chezmoi diff

# Add a new file to management
chezmoi add ~/.config/some-app/config.toml
```

## Cross-platform design

- **zsh** is the shell on both platforms (config lives in `~/.zsh`, loaded from `~/.zshrc`).
- **mise** manages language runtimes (node/python/go/ruby/bun/uv) and is platform-agnostic.
- **Homebrew is macOS-only**; Linux uses its system package manager (`apt`/`dnf`).
- Platform differences are handled with chezmoi templates (`{{ if eq .chezmoi.os "linux" }}`)
  in `dot_zsh/10-paths.zsh.tmpl` and `dot_zsh/60-java.zsh`.
- bash config files (`~/.profile`, `~/.bashrc`) are also chezmoi-managed as a
  compatibility layer for bash-invoking environments; zsh remains the primary shell.

## Java (platform-native, multiple versions)

JDKs are **not** managed by mise. They come from the platform package manager:

- **macOS**: `brew install --cask zulu8 zulu11 zulu17 zulu21` → `/Library/Java/JavaVirtualMachines`
- **Linux**: `apt install openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk openjdk-21-jdk`
  (or `dnf install java-17-openjdk-devel`), default picked via `update-alternatives`

The global default `JAVA_HOME` is set in `~/.zsh/60-java.zsh` (macOS: `java_home`,
Linux: resolves the `java` symlink). For a project-specific JDK, drop a `.zprofile`
in the project root (auto-loaded by `50-autoenv.zsh`):

```sh
# macOS
export JAVA_HOME="$(/usr/libexec/java_home -v 11)"
# Debian/Ubuntu
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
```

## Language runtimes

This repo uses `mise` as the global language/runtime manager.

- The config lives in `dot_config/mise/config.toml` and is applied to `~/.config/mise`.
- `chezmoi apply` will run `mise install` automatically when `mise/config.toml` changes.
- Python tooling is integrated with `uv`; existing `uv` project venvs can be auto-activated.
- If you install Python with `uv`, run `mise sync python --uv` to sync interpreters into `mise`.
- Project-local `mise.toml`, `.tool-versions`, `.nvmrc`, `.python-version`, and `.ruby-version` can still override the global defaults.

## Windows

Legacy PowerShell configs are archived in `pc/` for reference only and are **not**
managed by chezmoi. See `pc/README.md`.
