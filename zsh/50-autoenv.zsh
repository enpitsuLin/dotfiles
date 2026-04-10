# Auto-load .zprofile when changing directories using chpwd hook

# Ensure functions module is loaded for add-zsh-hook
autoload -Uz add-zsh-hook

# Store the last loaded .zprofile path to avoid reloading
_typeset_last_loaded_zprofile=""

# Function to load .zprofile from current directory
_autoenv_chpwd() {
  local zprofile_path="${PWD}/.zprofile"
  
  # If we already loaded this exact file, do nothing
  if [[ "${_typeset_last_loaded_zprofile}" == "${zprofile_path}" ]]; then
    return 0
  fi
  
  # If .zprofile exists in current directory, load it
  if [[ -f "${zprofile_path}" ]]; then
    source "${zprofile_path}"
    _typeset_last_loaded_zprofile="${zprofile_path}"
  else
    # Clear the tracking when moving to a directory without .zprofile
    _typeset_last_loaded_zprofile=""
  fi
}

# Register the function with chpwd hook
add-zsh-hook chpwd _autoenv_chpwd

# Also run once on shell startup to handle initial directory
_autoenv_chpwd
