#!/bin/bash

# Ensure gum is installed for prompts
if ! command -v gum >/dev/null 2>&1; then
  echo "gum not found. Installing gum for interactive prompts..."
  GUM_VERSION="0.14.3"
  ARCH="$(uname -m)"
  if [ "$ARCH" != "x86_64" ]; then
    echo "Unsupported architecture for gum binary install: $ARCH"
    exit 1
  fi
  cd /tmp
  wget -qO gum.deb "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_amd64.deb"
  if ! sudo apt-get install -y --allow-downgrades ./gum.deb; then
    echo "\033[31mError: Failed to install gum. You may need to resolve dependencies manually (e.g., run 'sudo apt --fix-broken install').\033[0m"
    rm -f gum.deb
    exit 1
  fi
  rm gum.deb
  cd -
fi

# Check if Gnome is installed
if ! command -v gnome-shell >/dev/null 2>&1; then
  echo "Gnome is not installed. Installing Gnome desktop environment..."
  sudo apt update
  # Install Gnome desktop environment and tweaks
  if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
    sudo apt install -y gnome-shell gnome-session gnome-terminal gnome-control-center gnome-tweaks
  else
    echo "Unsupported OS for Gnome desktop installation."
    exit 1
  fi
  echo "Gnome installation complete."
  # Prompt user to reboot or continue
  if gum confirm "Gnome has been installed. You must reboot to start a GNOME session and install desktop apps. Reboot now?"; then
    echo "Rebooting... Please log in to GNOME and then run: source ~/.local/share/omakub/install/desktop-only.sh to complete desktop setup."
    sudo reboot
    exit 0
  else
    echo "Continuing with terminal-only installation. After rebooting into GNOME, run: source ~/.local/share/omakub/install/desktop-only.sh to complete desktop setup."
  fi
else
  echo "Gnome is already installed."
fi

# Check if GDM is the current login manager
if [ -x "$(command -v systemctl)" ]; then
  CURRENT_DM=$(cat /etc/X11/default-display-manager 2>/dev/null || echo "")
  if [[ "$CURRENT_DM" != *gdm* ]]; then
    echo "GDM (Gnome Display Manager) is not the current login manager."
    if gum confirm "Do you want to switch to GDM (Gnome Display Manager)?"; then
      # Install GDM (Gnome Display Manager) if needed
      if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
        sudo apt install -y gdm3
      else
        echo "Unsupported OS for GDM installation."
        exit 1
      fi
      sudo systemctl disable --now lightdm 2>/dev/null || true
      sudo systemctl enable --now gdm3
      echo "GDM is now set as the default login manager."
    else
      echo "Skipping GDM setup. You may need to set it manually for full Gnome experience."
    fi
  else
    echo "GDM is already the current login manager."
  fi
fi
