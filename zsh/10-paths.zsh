path_prepend() {
  local dir="$1"

  case ":$PATH:" in
    *":$dir:"*) ;;
    *) export PATH="$dir:$PATH" ;;
  esac
}

path_append() {
  local dir="$1"

  case ":$PATH:" in
    *":$dir:"*) ;;
    *) export PATH="$PATH:$dir" ;;
  esac
}

path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.cargo/bin"

case "$(uname)" in
  Darwin)
    export PNPM_HOME="$HOME/Library/pnpm"

    if [ -z "$ANDROID_HOME" ]; then
      export ANDROID_HOME="$HOME/Library/Android/sdk"
    fi

    export LDFLAGS="-L/opt/homebrew/opt/boost@1.76/lib -L/opt/homebrew/opt/zlib/lib -L/opt/homebrew/opt/bzip2/lib${LDFLAGS:+ $LDFLAGS}"
    export CPPFLAGS="-I/opt/homebrew/opt/boost@1.76/include -I/opt/homebrew/opt/zlib/include -I/opt/homebrew/opt/bzip2/include${CPPFLAGS:+ $CPPFLAGS}"

    [ -d "/opt/homebrew/opt/bzip2/bin" ] && path_prepend "/opt/homebrew/opt/bzip2/bin"
    [ -d "/opt/homebrew/opt/python@3.13/libexec/bin" ] && path_prepend "/opt/homebrew/opt/python@3.13/libexec/bin"
    ;;
  *)
    export PNPM_HOME="$HOME/.local/share/pnpm"
    ;;
esac

path_prepend "$PNPM_HOME"

if [ -n "$ANDROID_HOME" ] && [ -d "$ANDROID_HOME" ]; then
  path_append "$ANDROID_HOME/platform-tools"
  path_append "$ANDROID_HOME/tools"
  path_append "$ANDROID_HOME/tools/bin"
  path_append "$ANDROID_HOME/emulator"
fi

[ -d "/mnt/c/Users/enpitsulin/AppData/Local/Programs/cursor/resources/app/bin" ] && \
  path_prepend "/mnt/c/Users/enpitsulin/AppData/Local/Programs/cursor/resources/app/bin"

unset -f path_prepend path_append
