# Install fzf, ripgrep, bat, zoxide, plocate, apache2-utils, fd-find, tldr (all available in both Ubuntu and Debian)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y fzf ripgrep bat zoxide plocate apache2-utils fd-find tldr
else
  echo "Unsupported OS for core terminal utilities installation."
  exit 1
fi

# Install eza (modern exa replacement)
if ! command -v eza >/dev/null 2>&1; then
  if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
    sudo apt install -y eza
  elif [ "$OMAKUB_OS_ID" = "debian" ]; then
    cd /tmp
    EZA_URL=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep browser_download_url | grep 'eza_x86_64-unknown-linux-gnu.tar.gz' | cut -d '"' -f 4 | head -n 1)
    if [ -z "$EZA_URL" ]; then
      echo "Could not find eza binary for Debian. Aborting."
      exit 1
    fi
    wget -O eza.tar.gz "$EZA_URL"
    tar -xzf eza.tar.gz
    # The binary is usually in the extracted folder, find and move it
    EZA_BIN=$(find . -type f -name eza | head -n 1)
    if [ -z "$EZA_BIN" ]; then
      echo "eza binary not found in archive. Aborting."
      exit 1
    fi
    chmod +x "$EZA_BIN"
    sudo mv "$EZA_BIN" /usr/local/bin/eza
    rm -rf eza.tar.gz eza-*
    cd -
  fi
else
  echo "eza is already installed, skipping."
fi

# Install btop (resource monitor)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y btop
else
  echo "Unsupported OS for btop installation."
  exit 1
fi

# Install GitHub CLI (gh)
if ! command -v gh >/dev/null 2>&1; then
  if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    sudo apt update
    sudo apt install -y gh
  fi
else
  echo "gh (GitHub CLI) is already installed, skipping."
fi

# Install xournalpp (note-taking app)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y xournalpp
else
  echo "Unsupported OS for xournalpp installation."
  exit 1
fi

# Install MySQL/MariaDB development libraries
if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  sudo apt install -y libmysqlclient-dev
elif [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y libmariadb-dev libmariadb-dev-compat
else
  echo "Unsupported OS for MySQL/MariaDB dev libraries installation."
  exit 1
fi
