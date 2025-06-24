#!/bin/bash

# Check if GNOME and GDM3 are installed. Refuse to continue if not, print instructions.

missing=0
if ! command -v gnome-shell >/dev/null 2>&1; then
  echo "Error: GNOME desktop (gnome-shell) is not installed."
  missing=1
fi
if ! systemctl status gdm3 >/dev/null 2>&1; then
  echo "Error: GDM3 (Gnome Display Manager) is not installed or not enabled."
  missing=1
fi

if [ "$missing" -ne 0 ]; then
  echo
  echo "To install GNOME and GDM3, run:"
  echo "  sudo apt update"
  echo "  sudo apt install -y gnome-shell gnome-session gnome-terminal gnome-control-center gnome-tweaks gdm3"
  echo
  echo "After installation, reboot your system and log into GNOME."
  echo "Then re-run the Omakub installer."
  exit 1
fi

echo "GNOME and GDM3 are installed. Continuing..."
