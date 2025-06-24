#!/bin/bash
# Optional: lazygit
if command -v lazygit >/dev/null 2>&1; then
  LAZYGIT_VERSION=$(lazygit --version 2>/dev/null | head -n 1)
  echo "lazygit is already installed: $LAZYGIT_VERSION. Skipping install."
  exit 0
fi

if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! sudo apt update -y; then
    echo "Error: Failed to update apt sources."; exit 1; fi
  if ! sudo apt install -y lazygit; then
    echo "Error: Failed to install lazygit."; exit 1; fi
else
  echo "Unsupported OS for lazygit installation."; exit 1;
fi

if command -v lazygit >/dev/null 2>&1; then
  LAZYGIT_VERSION=$(lazygit --version 2>/dev/null | head -n 1)
  echo "lazygit installed successfully: $LAZYGIT_VERSION."
else
  echo "lazygit installation failed."; exit 1;
fi
