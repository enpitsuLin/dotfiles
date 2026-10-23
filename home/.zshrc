# Homebrew path for macOS
if [[ "$(uname)" == "Darwin" ]] && [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load shell modules from ~/.zsh
ZSH_PATH="${HOME}/.zsh"

# Load shell modules in order by responsibility.
for file in ${ZSH_PATH}/[0-9][0-9]-*.zsh(N); do
  source "$file"
done
