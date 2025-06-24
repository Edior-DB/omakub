# Install fzf, ripgrep, bat, zoxide, plocate, apache2-utils, fd-find, tldr (all available in both Ubuntu and Debian)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! sudo apt install -y fzf ripgrep bat zoxide plocate apache2-utils fd-find tldr; then
    echo "Error: Failed to install one or more core terminal utilities. Check your apt sources and package names."
    exit 1
  fi
else
  echo "Unsupported OS for core terminal utilities installation."
  exit 1
fi

# Install eza (modern exa replacement)
if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  if ! sudo apt install -y eza; then
    echo "Error: Failed to install eza on Ubuntu."
    exit 1
  fi
elif [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! command -v eza >/dev/null 2>&1; then
    # Check for latest version
    LATEST_EZA_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep 'tag_name' | cut -d '"' -f4 | sed 's/^v//')
    INSTALLED_EZA_VERSION=$(command -v eza >/dev/null 2>&1 && eza --version 2>/dev/null | awk '{print $2}')
    if [ "$INSTALLED_EZA_VERSION" = "$LATEST_EZA_VERSION" ]; then
      echo "eza $LATEST_EZA_VERSION is already installed, skipping."
    else
      cd /tmp
      EZA_URL=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep browser_download_url | grep 'eza_x86_64-unknown-linux-gnu.tar.gz' | cut -d '"' -f 4 | head -n 1)
      if [ -z "$EZA_URL" ]; then
        echo "Could not find eza binary for Debian. Aborting."
        exit 1
      fi
      if ! wget -O eza.tar.gz "$EZA_URL"; then
        echo "Error: Failed to download eza binary."
        exit 1
      fi
      if ! tar -xzf eza.tar.gz; then
        echo "Error: Failed to extract eza binary."
        exit 1
      fi
      EZA_BIN=$(find . -type f -name eza | head -n 1)
      if [ -z "$EZA_BIN" ]; then
        echo "eza binary not found in archive. Aborting."
        exit 1
      fi
      chmod +x "$EZA_BIN"
      if ! sudo mv "$EZA_BIN" /usr/local/bin/eza; then
        echo "Error: Failed to move eza binary to /usr/local/bin."
        exit 1
      fi
      rm -rf eza.tar.gz eza-*
      cd -
      if ! command -v eza >/dev/null 2>&1; then
        echo "Error: eza was not found in /usr/local/bin after install. Check your PATH."
        exit 1
      fi
    fi
  else
    # If already installed, check version
    LATEST_EZA_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep 'tag_name' | cut -d '"' -f4 | sed 's/^v//')
    INSTALLED_EZA_VERSION=$(eza --version 2>/dev/null | awk '{print $2}')
    if [ "$INSTALLED_EZA_VERSION" = "$LATEST_EZA_VERSION" ]; then
      echo "eza $LATEST_EZA_VERSION is already installed, skipping."
    else
      echo "eza is installed but not at latest version ($INSTALLED_EZA_VERSION). Consider updating manually."
    fi
  fi
else
  echo "Unsupported OS for eza installation."
  exit 1
fi

# Install btop (resource monitor)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! sudo apt install -y btop; then
    echo "Error: Failed to install btop."
    exit 1
  fi
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
    if ! sudo apt install -y gh; then
      echo "Error: Failed to install GitHub CLI (gh)."
      exit 1
    fi
  fi
else
  echo "gh (GitHub CLI) is already installed, skipping."
fi

# Install xournalpp (note-taking app)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! sudo apt install -y xournalpp; then
    echo "Error: Failed to install xournalpp."
    exit 1
  fi
else
  echo "Unsupported OS for xournalpp installation."
  exit 1
fi

# Install MySQL/MariaDB development libraries
if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  if ! sudo apt install -y libmysqlclient-dev; then
    echo "Error: Failed to install libmysqlclient-dev."
    exit 1
  fi
elif [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! sudo apt install -y libmariadb-dev libmariadb-dev-compat; then
    echo "Error: Failed to install MariaDB dev libraries."
    exit 1
  fi
else
  echo "Unsupported OS for MySQL/MariaDB dev libraries installation."
  exit 1
fi
