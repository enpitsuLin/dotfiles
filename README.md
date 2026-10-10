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
Homebrew (macOS) or system packages (Linux), mise, and starship. Language
runtimes, including Java, are installed by mise after its config is applied.
A fresh login shell is required afterwards.

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
- **mise** manages language runtimes (node/python/go/ruby/java/bun/uv) and is platform-agnostic.
- **Homebrew is macOS-only**; Linux uses its system package manager (`apt`/`dnf`).
- Platform differences are handled with chezmoi templates (`{{ if eq .chezmoi.os "linux" }}`)
  such as `dot_zsh/10-paths.zsh.tmpl` and `run_once_bootstrap.sh.tmpl`.
- bash config files (`~/.profile`, `~/.bashrc`) are also chezmoi-managed as a
  compatibility layer for bash-invoking environments; zsh remains the primary shell.

## Java (managed by mise)

Java uses the global mise configuration, like the other language runtimes.
The default is Zulu 17; mise activation sets `JAVA_HOME` and the Java command path.
The shell and bootstrap scripts no longer select or install a platform JDK.

For a project-specific JDK, set Java in the project's `mise.toml`:

```toml
[tools]
java = "zulu-17.68.17.0"
```

Run `mise install` in the project to install any missing runtime. Existing
Homebrew OpenJDK installations can still be required by tools such as apktool
or jadx and should be removed only after checking their installed dependents.

## Language runtimes

This repo uses `mise` as the global language/runtime manager.

- The config source is `dot_config/mise/config.toml.tmpl`, rendered to `~/.config/mise/config.toml`.
- `chezmoi apply` will run `mise install` automatically when `mise/config.toml` changes.
- Python tooling is integrated with `uv`; existing `uv` project venvs can be auto-activated.
- If you install Python with `uv`, run `mise sync python --uv` to sync interpreters into `mise`.
- Project-local `mise.toml`, `.tool-versions`, `.nvmrc`, `.python-version`, and `.ruby-version` can still override the global defaults.

## GPG / commit signing

On macOS, commits are signed by default (`commit.gpgsign = true` in
`dot_gitconfig.tmpl`) with the key `0672CB8176D09B46A823B81C85C836DC516B372C`.

- `gnupg` and `pinentry-mac` are installed by the bootstrap script.
- Passphrase prompts go through `~/.local/bin/pinentry-dispatch` (managed as
  `dot_local/bin/executable_pinentry-dispatch`, wired up by
  `private_dot_gnupg/gpg-agent.conf.tmpl`): terminal clients prompt in the
  terminal, GUI clients (VSCode, IDEs, GitHub Desktop) show a native dialog.
- GnuPG re-reads `gpg-agent.conf` on restart; run `gpgconf --kill gpg-agent`
  after changing it (the agent restarts automatically).
- The private key is **not** managed by this repo and must be imported once per
  machine:

```sh
gpg --import /path/to/private-key.asc
gpg --list-secret-keys --keyid-format=long   # expect ...516B372C
```

Until the key is imported, `git commit` fails; bypass signing with
`git -c commit.gpgsign=false commit`.

## Windows

Legacy PowerShell configs are archived in `pc/` for reference only and are **not**
managed by chezmoi. See `pc/README.md`.
