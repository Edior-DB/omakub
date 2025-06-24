# Obsidian is a multi-platform note taking application. See https://obsidian.md
# Idempotent install: check if already installed

# Check if obsidian is installed before running --version
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
  wget -O obsidian.deb "$OBSIDIAN_DEB_URL"
  sudo apt install -y ./obsidian.deb
  rm obsidian.deb
  cd -
else
  # Use snap for Ubuntu and other supported systems
  sudo snap install obsidian
fi
