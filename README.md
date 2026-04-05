# enpitsulin's dotfiles

use dotbot to manage

## To use

run 

```sh
chmod +x install
install
```

## Language runtimes

This repo uses `mise` as the global language/runtime manager.

- The config lives in `mise/config.toml` and is linked to `~/.config/mise`.
- `./install` will run `mise install` when `mise` is already available.
- Python tooling is integrated with `uv`; existing `uv` project venvs can be auto-activated.
- If you install Python with `uv`, run `mise sync python --uv` to sync interpreters into `mise`.
- Project-local `mise.toml`, `.tool-versions`, `.nvmrc`, `.python-version`, and `.ruby-version` can still override the global defaults.
