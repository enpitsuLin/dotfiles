# Auto-load .zprofile when changing directories using chpwd hook

# Ensure functions module is loaded for add-zsh-hook
autoload -Uz add-zsh-hook

# Store the last loaded .zprofile path to avoid reloading
_typeset_last_loaded_zprofile=""

# Function to load .zprofile from current directory
_autoenv_chpwd() {
  local zprofile_path="${PWD}/.zprofile"
  local zprofile_local_path="${PWD}/.zprofile.local"
  local target_path=""
  
  # Prefer .zprofile.local over .zprofile
  if [[ -f "${zprofile_local_path}" ]]; then
    target_path="${zprofile_local_path}"
  elif [[ -f "${zprofile_path}" ]]; then
    target_path="${zprofile_path}"
  fi
  
  # If we already loaded this exact file, do nothing
  if [[ "${_typeset_last_loaded_zprofile}" == "${target_path}" ]]; then
    return 0
  fi
  
  # Load the target file if found
  if [[ -n "${target_path}" ]]; then
    source "${target_path}"
    _typeset_last_loaded_zprofile="${target_path}"
  else
    # Clear the tracking when moving to a directory without .zprofile
    _typeset_last_loaded_zprofile=""
  fi
}

# Register the function with chpwd hook
add-zsh-hook chpwd _autoenv_chpwd

# Also run once on shell startup to handle initial directory
_autoenv_chpwd
