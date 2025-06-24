# Idempotent install: check if Steam is already installed
if command -v steam >/dev/null 2>&1; then
  STEAM_VERSION=$(steam --version 2>/dev/null | head -n 1)
  echo "Steam is already installed: $STEAM_VERSION. Skipping install."
  exit 0
fi

# Play games from https://store.steampowered.com/
cd /tmp
wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb
sudo apt install -y ./steam.deb
rm steam.deb
cd -
