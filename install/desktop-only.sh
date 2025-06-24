#!/bin/bash
# Omakub Desktop-Only Installer
# Installs only desktop apps and tweaks. Run this after logging into GNOME if you installed GNOME mid-process.

set -eEuo pipefail

# Initialize for error reporting
current_command=""
last_command=""

# Improved error reporting
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo -e "\nOmakub desktop-only installation failed!\n  Command: $last_command\n  Exit code: $?\n  You can retry by running: source ~/.local/share/omakub/install/desktop-only.sh"; while true; do sleep 1; done' ERR

# Check for GNOME session
if [[ "$XDG_CURRENT_DESKTOP" != *"GNOME"* ]]; then
  echo "You are not running a GNOME session. Please log in to GNOME before running this script."
  exit 1
fi

# Install desktop tools and tweaks
source ~/.local/share/omakub/install/desktop.sh

echo "Desktop apps and tweaks installation complete!"
