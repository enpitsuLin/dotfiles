# https://mise.jdx.dev/
typeset -gaU path

clean_path=()
for path_entry in "${path[@]}"; do
  case "$path_entry" in
    /run/user/*/fnm_multishells/*/bin|\
    "$HOME/.bun/bin"|\
    "$HOME/.local/share/fnm"|\
    "$HOME/.volta"|\
    "$HOME/Library/pnpm")
      ;;
    *)
      clean_path+=("$path_entry")
      ;;
  esac
done
path=("${clean_path[@]}")

unset BUN_INSTALL FNM_DIR FNM_MULTISHELL_PATH PNPM_HOME VOLTA_FEATURE_PNPM VOLTA_HOME

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
elif [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi
