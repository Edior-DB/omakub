#!/bin/bash
# Optional: lazygit
if command -v lazygit >/dev/null 2>&1; then
  LAZYGIT_VERSION=$(lazygit --version 2>/dev/null | head -n 1)
  echo "lazygit is already installed: $LAZYGIT_VERSION. Skipping install."
else
  if [ "$OMAKUB_OS_ID" = "ubuntu" ] && [ "$OMAKUB_OS_VERSION_ID" = "24.04" ]; then
    # Ubuntu 24.04+ method
    cd /tmp || exit 1
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar -xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz lazygit
    mkdir -p ~/.config/lazygit/
    touch ~/.config/lazygit/config.yml
    cd - || true
  elif [ "$OMAKUB_OS_ID" = "debian" ] && [ "$OMAKUB_OS_VERSION_ID" = "12" ]; then
    # Debian 12 method (as per GitHub repo)
    cd /tmp || exit 1
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
    rm lazygit.tar.gz lazygit
    mkdir -p ~/.config/lazygit/
    touch ~/.config/lazygit/config.yml
    cd - || true
  else
    echo "Unsupported OS version for this installer."
    return 1
  fi

  if command -v lazygit >/dev/null 2>&1; then
    LAZYGIT_VERSION=$(lazygit --version 2>/dev/null | head -n 1)
    echo "lazygit installed successfully: $LAZYGIT_VERSION."
  else
    echo "lazygit installation failed."; return 1;
  fi
fi
