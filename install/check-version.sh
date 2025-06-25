#!/bin/bash

if [ ! -f /etc/os-release ]; then
  echo "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
  echo "Installation stopped."
  exit 1
fi

. /etc/os-release
export OMAKUB_OS_ID="$ID"
export OMAKUB_OS_VERSION_ID="$VERSION_ID"



# Check if running on Ubuntu 24.04+ or Debian 12+
if { [ "$ID" = "ubuntu" ] && [ $(echo "$VERSION_ID >= 24.04" | bc) -eq 1 ]; } || \
   { [ "$ID" = "debian" ] && [ $(echo "$VERSION_ID >= 12" | bc) -eq 1 ]; }; then
  : # Supported
else
  echo "$(tput setaf 1)Error: OS requirement not met"
  echo "You are currently running: $ID $VERSION_ID"
  echo "OS required: Ubuntu 24.04+ or Debian 12+ (bookworm)"
  echo "Installation stopped."
  exit 1
fi

# Ensure GNU awk is installed and set as default on Debian
if [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! command -v gawk >/dev/null 2>&1; then
    echo "Installing GNU awk (gawk) for better compatibility..."
    sudo apt-get update && sudo apt-get install -y gawk
  fi
  # Set gawk as the default awk if not already
  if [ "$(readlink -f /usr/bin/awk)" != "/usr/bin/gawk" ]; then
    sudo update-alternatives --set awk /usr/bin/gawk
  fi
fi

# Check if running on x86
ARCH=$(uname -m)
if [ "$ARCH" != "x86_64" ] && [ "$ARCH" != "i686" ]; then
  echo "$(tput setaf 1)Error: Unsupported architecture detected"
  echo "Current architecture: $ARCH"
  echo "This installation is only supported on x86 architectures (x86_64 or i686)."
  echo "Installation stopped."
  exit 1
fi
source ~/.local/share/omakub/install/check-gnome.sh

sudo apt-get update >/dev/null

