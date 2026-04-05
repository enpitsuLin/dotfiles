# Gpg fixed
export GPG_TTY=$(tty)
# Homebrew path for macOS
if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Keep user-installed CLIs available before loading shell modules.
if [ -d "$HOME/.local/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
  esac
fi

# Variables environments
DOTFILE_PATH="${HOME}/.dotfiles"
ZSH_PATH="${DOTFILE_PATH}/zsh/"

# Load shell modules first, then let mise normalize PATH last.
for file in ${ZSH_PATH}*.zsh; do
  [ "$file" = "${ZSH_PATH}mise.zsh" ] && continue
  [ -f "$file" ] && source "$file"
done
[ -f "${ZSH_PATH}mise.zsh" ] && source "${ZSH_PATH}mise.zsh"

# Android environment variable
export ANDROID_HOME=$HOME/Library/Android/sdk
if [ -d "$ANDROID_HOME" ]; then
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/tools/bin
  export PATH=$PATH:$ANDROID_HOME/emulator
fi

# pnpm global binaries
case "$(uname)" in
  Darwin) export PNPM_HOME="$HOME/Library/pnpm" ;;
  *) export PNPM_HOME="$HOME/.local/share/pnpm" ;;
esac
if [ -d "$PNPM_HOME" ]; then
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

# Cursor (WSL)
[ -d "/mnt/c/Users/enpitsulin/AppData/Local/Programs/cursor/resources/app/bin" ] && \
  export PATH="/mnt/c/Users/enpitsulin/AppData/Local/Programs/cursor/resources/app/bin:$PATH"

# Homebrew libs
export LDFLAGS="-L/opt/homebrew/opt/boost@1.76/lib -L/opt/homebrew/opt/zlib/lib -L/opt/homebrew/opt/bzip2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/boost@1.76/include -I/opt/homebrew/opt/zlib/include -I/opt/homebrew/opt/bzip2/include"
[ -d "/opt/homebrew/opt/bzip2/bin" ] && export PATH="/opt/homebrew/opt/bzip2/bin:$PATH"
[ -d "/opt/homebrew/opt/python@3.13/libexec/bin" ] && export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
