#!/bin/bash

# Check if Gnome is installed
if ! command -v gnome-shell >/dev/null 2>&1; then
  echo "Gnome is not installed. Installing Gnome desktop environment..."
  sudo apt update
  sudo apt install -y gnome-shell gnome-session gnome-terminal gnome-control-center gnome-tweaks
  echo "Gnome installation complete."
else
  echo "Gnome is already installed."
fi

# Check if GDM is the current login manager
if [ -x "$(command -v systemctl)" ]; then
  CURRENT_DM=$(cat /etc/X11/default-display-manager 2>/dev/null || echo "")
  if [[ "$CURRENT_DM" != *gdm* ]]; then
    echo "GDM (Gnome Display Manager) is not the current login manager."
    read -p "Do you want to switch to GDM? [y/N]: " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      sudo apt install -y gdm3
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
