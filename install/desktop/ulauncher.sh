if [ -f /etc/os-release ]; then
  . /etc/os-release
fi

# Idempotent install: check if ulauncher is installed before running --version
if command -v ulauncher >/dev/null 2>&1; then
  ULAUNCHER_VERSION=$(ulauncher --version 2>/dev/null | head -n 1)
  echo "Ulauncher is already installed: $ULAUNCHER_VERSION. Skipping install."
else
  if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
    if ! gpg --keyserver keyserver.ubuntu.com --recv 0xfaf1020699503176; then
      echo "Error: Failed to receive Ulauncher GPG key."; exit 1; fi
    if ! gpg --export 0xfaf1020699503176 | sudo tee /usr/share/keyrings/ulauncher-archive-keyring.gpg >/dev/null; then
      echo "Error: Failed to export Ulauncher GPG key."; exit 1; fi
    if ! echo "deb [signed-by=/usr/share/keyrings/ulauncher-archive-keyring.gpg] http://ppa.launchpad.net/agornostal/ulauncher/ubuntu noble main" | sudo tee /etc/apt/sources.list.d/ulauncher-noble.list; then
      echo "Error: Failed to add Ulauncher PPA."; exit 1; fi
    if ! sudo apt update -y; then
      echo "Error: Failed to update apt sources."; exit 1; fi
    if ! sudo apt install -y ulauncher; then
      echo "Error: Failed to install ulauncher on Ubuntu."; exit 1; fi
  elif [ "$OMAKUB_OS_ID" = "debian" ]; then
    if ! command -v ulauncher >/dev/null 2>&1; then
      cd /tmp
      ULVER=$(curl -s https://api.github.com/repos/Ulauncher/Ulauncher/releases/latest | grep 'tag_name' | cut -d" -f4)
      if [ -z "$ULVER" ]; then
        echo "Error: Could not determine latest Ulauncher version."; exit 1; fi
      if ! wget -O ulauncher.deb "https://github.com/Ulauncher/Ulauncher/releases/download/$ULVER/ulauncher_${ULVER#v}_all.deb"; then
        echo "Error: Failed to download Ulauncher .deb."; exit 1; fi
      if ! sudo apt install -y ./ulauncher.deb; then
        echo "Error: Failed to install Ulauncher .deb."; exit 1; fi
      rm ulauncher.deb
      cd -
    else
      echo "ulauncher is already installed, skipping."
    fi
  else
    echo "Unsupported OS for Ulauncher installation."; exit 1;
  fi
fi

# Start ulauncher to have it populate config before we overwrite
mkdir -p ~/.config/autostart/
cp ~/.local/share/omakub/configs/ulauncher.desktop ~/.config/autostart/ulauncher.desktop
gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults
cp ~/.local/share/omakub/configs/ulauncher.json ~/.config/ulauncher/settings.json
