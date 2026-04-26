# enpitsulin's dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Prerequisites

- [chezmoi](https://www.chezmoi.io/install/)
- [starship](https://starship.rs/guide/#%F0%9F%8D%B0-installation)
- [mise](https://mise.jdx.dev/getting-started.html)

## Quick start

```sh
# One-shot install and apply
chezmoi init --apply https://github.com/enpitsulin/dotfiles.git
```

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

## Language runtimes

This repo uses `mise` as the global language/runtime manager.

- The config lives in `dot_config/mise/config.toml` and is applied to `~/.config/mise`.
- `chezmoi apply` will run `mise install` automatically when `mise/config.toml` changes.
- Python tooling is integrated with `uv`; existing `uv` project venvs can be auto-activated.
- If you install Python with `uv`, run `mise sync python --uv` to sync interpreters into `mise`.
- Project-local `mise.toml`, `.tool-versions`, `.nvmrc`, `.python-version`, and `.ruby-version` can still override the global defaults.

## Windows (PowerShell)

PowerShell-specific configs are kept in the `pc/` directory for reference but are **not** managed by chezmoi. Apply them manually if needed.
