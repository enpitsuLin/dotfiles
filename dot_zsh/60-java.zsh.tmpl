# Java: platform-native JDKs (brew casks on macOS, system packages on Linux).
# mise deliberately does NOT manage Java; the platform package manager does.
#
# Global default JAVA_HOME below. To pick a different JDK for a project, drop a
# .zprofile in the project root (auto-loaded by 50-autoenv.zsh), e.g.:
#   macOS:  export JAVA_HOME="$(/usr/libexec/java_home -v 11)"
#   Debian: export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
{{ if eq .chezmoi.os "darwin" }}
if command -v /usr/libexec/java_home >/dev/null 2>&1; then
  _java_home="$(/usr/libexec/java_home 2>/dev/null)"
  [ -n "$_java_home" ] && export JAVA_HOME="$_java_home"
  unset _java_home
fi
{{ else }}
if command -v java >/dev/null 2>&1; then
  _java_bin="$(readlink -f "$(command -v java)" 2>/dev/null)"
  [ -n "$_java_bin" ] && export JAVA_HOME="${_java_bin%/bin/java}"
  unset _java_bin
fi
{{ end }}

# Put the default JDK on PATH
[ -n "$JAVA_HOME" ] && [ -d "$JAVA_HOME/bin" ] && export PATH="$JAVA_HOME/bin:$PATH"
