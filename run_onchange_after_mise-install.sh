#!/bin/bash
# Run mise install when this script or mise config changes
if command -v mise >/dev/null 2>&1; then
  mise install
elif [ -x "$HOME/.local/bin/mise" ]; then
  "$HOME/.local/bin/mise" install
fi
