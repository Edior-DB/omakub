#!/bin/bash
# Optional: Obsidian
# Idempotent install: check if obsidian is installed before running --version
if command -v obsidian >/dev/null 2>&1; then
  OBSIDIAN_VERSION=$(obsidian --version 2>/dev/null | head -n 1)
  echo "Obsidian is already installed: $OBSIDIAN_VERSION. Skipping install."
  exit 0
fi

gum spin --spinner meter --title "Obsidian installation about to start. It may take up to 20 minutes on some systems!" -- sleep 3

if [ "$OMAKUB_OS_ID" = "debian" ]; then
  # Install official .deb for Debian
  cd /tmp
  OBSIDIAN_DEB_URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep browser_download_url | grep 'amd64.deb' | cut -d '"' -f 4 | head -n 1)
  if [ -z "$OBSIDIAN_DEB_URL" ]; then
    echo "Could not find Obsidian .deb for Debian. Aborting."
    exit 1
  fi
  if ! wget -O obsidian.deb "$OBSIDIAN_DEB_URL"; then
    echo "Error: Failed to download Obsidian .deb."; exit 1; fi
  if ! sudo apt install -y ./obsidian.deb; then
    echo "Error: Failed to install Obsidian .deb."; exit 1; fi
  rm obsidian.deb
  cd -
  if ! command -v obsidian >/dev/null 2>&1; then
    echo "Error: Obsidian was not found after install. Check your PATH."; exit 1; fi
else
  # Use snap for Ubuntu and other supported systems
  if ! sudo snap install obsidian; then
    echo "Error: Failed to install Obsidian via snap."; exit 1; fi
  if ! command -v obsidian >/dev/null 2>&1; then
    echo "Error: Obsidian was not found after snap install. Check your PATH."; exit 1; fi
fi

# Final check and version print
if command -v obsidian >/dev/null 2>&1; then
  OBSIDIAN_VERSION=$(obsidian --version 2>/dev/null | head -n 1)
  echo "Obsidian installed successfully: $OBSIDIAN_VERSION."
else
  echo "Obsidian installation failed."
  exit 1
fi
