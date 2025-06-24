#!/bin/bash
# Optional: Fastfetch system info tool
if command -v fastfetch >/dev/null 2>&1; then
  FASTFETCH_VERSION=$(fastfetch --version 2>/dev/null | head -n 1)
  echo "Fastfetch is already installed: $FASTFETCH_VERSION. Skipping install."
  exit 0
fi

if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
  sudo apt update -y
  sudo apt install -y fastfetch
elif [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt update -y
  # Download and install latest fastfetch .deb for amd64
  cd /tmp
  FASTFETCH_DEB_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep browser_download_url | grep 'amd64.deb' | cut -d '"' -f 4 | head -n 1)
  if [ -z "$FASTFETCH_DEB_URL" ]; then
    echo "Could not find fastfetch .deb for Debian. Aborting."
    exit 1
  fi
  wget -O fastfetch.deb "$FASTFETCH_DEB_URL"
  sudo apt install -y ./fastfetch.deb
  rm fastfetch.deb
  cd -
else
  echo "Unsupported OS for fastfetch installation."
  exit 1
fi

# Only attempt to set configuration if fastfetch is not already set
if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  # Use Omakub fastfetch config
  mkdir -p ~/.config/fastfetch
  cp ~/.local/share/omakub/configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
fi
