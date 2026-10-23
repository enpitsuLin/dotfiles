if [[ "$OSTYPE" == darwin* ]]; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    # mise can install Homebrew formulae without the brew command.
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  fi

  # Added by OrbStack: command-line tools and integration.
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :

  # Add Visual Studio Code (code).
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi
