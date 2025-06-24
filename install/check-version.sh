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

# Debian 12 peculiarity: check if user is in sudo group
if [ "$ID" = "debian" ] && [ $(echo "$VERSION_ID >= 12" | bc) -eq 1 ]; then
  if ! groups "$USER" | grep -qw sudo; then
    echo "$(tput setaf 1)Error: Your user ($USER) is not in the 'sudo' group."
    echo "On Debian 12+, you must add your user to the 'sudo' group and re-login before running this installer."
    echo "Switch to root with: su -"
    echo "Then run: /sbin/usermod -aG sudo <your-username>"
    echo "(Replace <your-username> with your actual username, e.g. '$(logname)' if unsure)"
    echo "After that, log out and log back in as your user, then re-run the installer."
    echo "For some weird reason, you might also need to reboot your system."
    echo "Installation stopped."
    exit 1
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
sudo apt-get install -y git >/dev/null
