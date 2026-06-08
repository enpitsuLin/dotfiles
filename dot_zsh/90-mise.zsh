# https://mise.jdx.dev/
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
elif [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

# rbenv override
if command -v rbenv >/dev/null 2>&1; then
  typeset -U path PATH
  eval "$(rbenv init - --no-rehash zsh)"
fi
