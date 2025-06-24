#!/bin/bash
# Optional: Alacritty terminal
if command -v alacritty >/dev/null 2>&1; then
  ALACRITTY_VERSION=$(alacritty --version 2>/dev/null | head -n 1)
  echo "Alacritty is already installed: $ALACRITTY_VERSION. Skipping install."
  exit 0
fi

if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  if ! sudo apt update -y; then
    echo "Error: Failed to update apt sources."; exit 1; fi
  if ! sudo apt install -y alacritty; then
    echo "Error: Failed to install Alacritty."; exit 1; fi
elif [ "$OMAKUB_OS_ID" = "debian" ]; then
  # Use Flatpak for Debian
  if ! command -v flatpak >/dev/null 2>&1; then
    echo "Flatpak is not installed. Please install Flatpak first."; exit 1; fi
  if ! flatpak list | grep -q org.alacritty.Alacritty; then
    if ! flatpak install -y flathub org.alacritty.Alacritty; then
      echo "Error: Failed to install Alacritty via Flatpak."; exit 1; fi
  fi
  # Add alias if not present
  if ! grep -q 'alias alacritty=' ~/.bashrc; then
    echo "alias alacritty='flatpak run org.alacritty.Alacritty'" >> ~/.bashrc
    echo "Added alias for alacritty to ~/.bashrc. Please restart your shell or run: source ~/.bashrc"
  fi
else
  echo "Unsupported OS for Alacritty installation."; exit 1;
fi

if command -v alacritty >/dev/null 2>&1; then
  ALACRITTY_VERSION=$(alacritty --version 2>/dev/null | head -n 1)
  echo "Alacritty installed successfully: $ALACRITTY_VERSION."
else
  echo "Alacritty installation failed."; exit 1;
fi
