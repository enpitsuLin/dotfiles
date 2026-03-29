# Gpg fixed
export GPG_TTY=$(tty)
# Homebrew path for macOS
if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Variables environments
DOTFILE_PATH="${HOME}/.dotfiles"
ZSH_PATH="${DOTFILE_PATH}/zsh/"

# Load all other configuation file
for file in ${ZSH_PATH}*.zsh; do
  [ -f "$file" ] && source "$file"
done

# Android environment variable
export ANDROID_HOME=$HOME/Library/Android/sdk
if [ -d "$ANDROID_HOME" ]; then
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/tools/bin
  export PATH=$PATH:$ANDROID_HOME/emulator
fi
 

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
if [ -d "$PNPM_HOME" ]; then
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi
# pnpm end
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"


# Ruby (Homebrew)
if [ -d "/opt/homebrew/opt/ruby@3.0/bin" ]; then
  export PATH="/opt/homebrew/opt/ruby@3.0/bin:$PATH"
  export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
  export BUNDLE_PATH="$HOME/.local/share/gem/ruby/3.0.0"
fi

# Cursor (WSL)
[ -d "/mnt/c/Users/enpitsulin/AppData/Local/Programs/cursor/resources/app/bin" ] && \
  export PATH="/mnt/c/Users/enpitsulin/AppData/Local/Programs/cursor/resources/app/bin:$PATH"

# Homebrew libs
export LDFLAGS="-L/opt/homebrew/opt/boost@1.76/lib -L/opt/homebrew/opt/zlib/lib -L/opt/homebrew/opt/bzip2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/boost@1.76/include -I/opt/homebrew/opt/zlib/include -I/opt/homebrew/opt/bzip2/include"
[ -d "/opt/homebrew/opt/bzip2/bin" ] && export PATH="/opt/homebrew/opt/bzip2/bin:$PATH"
[ -d "/opt/homebrew/opt/python@3.13/libexec/bin" ] && export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"

[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -s "$HOME/.deno/env" ] && source "$HOME/.deno/env"


command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init - zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# claude
export PATH="$HOME/.local/bin:$PATH"
