if command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG=~/.starship/starship.toml
  export STARSHIP_CACHE=~/.starship/cache

  eval "$(starship init zsh)"
fi
