#!/bin/bash

# Check if Gnome is installed
if ! command -v gnome-shell >/dev/null 2>&1; then
  if gum confirm "GNOME desktop is not installed. Do you want to install GNOME now?"; then
    sudo apt update
    if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
      sudo apt install -y gnome-shell gnome-session gnome-terminal gnome-control-center gnome-tweaks
      echo "GNOME installation complete."
    else
      echo "Unsupported OS for GNOME desktop installation."
      exit 1
    fi
  else
    echo "Skipping GNOME installation. Only terminal apps will be available."
    exit 0
  fi
else
  echo "GNOME is already installed."
fi

# Ask if user wants to install GDM (Gnome Display Manager)
if ! systemctl status gdm3 >/dev/null 2>&1; then
  if gum confirm "GDM (Gnome Display Manager) is not installed or enabled. Do you want to install and enable GDM now?"; then
    sudo apt install -y gdm3
    echo "GDM installation complete. The package manager may prompt you to select the default display manager."
  else
    echo "Skipping GDM installation. You may need to set it manually for full GNOME experience."
  fi
else
  echo "GDM is already installed and enabled."
fi

echo "\nA reboot is recommended. After rebooting into GNOME, run: source ~/.local/share/omakub/install/desktop-only.sh to complete desktop setup."
if gum confirm "Reboot now?"; then
  echo "Rebooting..."
  sudo reboot
  exit 0
else
  echo "You chose not to reboot now. Please reboot and run desktop-only.sh later."
fi
