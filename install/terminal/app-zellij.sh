#!/bin/bash
# Optional: zellij
if command -v zellij >/dev/null 2>&1; then
  ZELLIJ_VERSION=$(zellij --version 2>/dev/null | head -n 1)
  echo "zellij is already installed: $ZELLIJ_VERSION. Skipping install."
  exit 0
fi

if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! sudo apt update -y; then
    echo "Error: Failed to update apt sources."; exit 1; fi
  if ! sudo apt install -y zellij; then
    echo "Error: Failed to install zellij."; exit 1; fi
else
  echo "Unsupported OS for zellij installation."; exit 1;
fi

if command -v zellij >/dev/null 2>&1; then
  ZELLIJ_VERSION=$(zellij --version 2>/dev/null | head -n 1)
  echo "zellij installed successfully: $ZELLIJ_VERSION."
else
  echo "zellij installation failed."; exit 1;
fi
