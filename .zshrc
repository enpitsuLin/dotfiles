# Gpg fixed
export GPG_TTY=$(tty)

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
