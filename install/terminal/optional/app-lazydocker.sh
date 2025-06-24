#!/bin/bash
# Optional: lazydocker
if command -v lazydocker >/dev/null 2>&1; then
  LAZYDOCKER_VERSION=$(lazydocker --version 2>/dev/null | head -n 1)
  echo "lazydocker is already installed: $LAZYDOCKER_VERSION. Skipping install."
else
  if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
    if ! sudo apt update -y; then
      echo "Error: Failed to update apt sources."; return 1; fi
    if ! sudo apt install -y lazydocker; then
      echo "Error: Failed to install lazydocker."; return 1; fi
  else
    echo "Unsupported OS for lazydocker installation."; return 1;
  fi

  if command -v lazydocker >/dev/null 2>&1; then
    LAZYDOCKER_VERSION=$(lazydocker --version 2>/dev/null | head -n 1)
    echo "lazydocker installed successfully: $LAZYDOCKER_VERSION."
  else
    echo "lazydocker installation failed."; return 1;
  fi
fi
