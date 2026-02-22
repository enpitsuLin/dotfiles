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
for file in `ls ${ZSH_PATH}*.zsh`
do
  source $file
done

# Android environment variable
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/emulator
 

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
eval "$(fnm env --use-on-cd)"


export PATH="/opt/homebrew/opt/ruby@3.0/bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
export BUNDLE_PATH="$HOME/.local/share/gem/ruby/3.0.0"

export PATH="/mnt/c/Users/enpitsulin/AppData/Local/Programs/cursor/resources/app/bin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/boost@1.76/lib"
export CPPFLAGS="-I/opt/homebrew/opt/boost@1.76/include"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export LDFLAGS="-L/opt/homebrew/opt/bzip2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/bzip2/include"
export PATH="/opt/homebrew/opt/bzip2/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"

source "$HOME/.cargo/env"
source "$HOME/.deno/env"


eval "$(rbenv init - zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# claude
export PATH="$HOME/.local/bin:$PATH"
