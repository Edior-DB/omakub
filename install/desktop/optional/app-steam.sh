# Idempotent install: check if Steam is already installed
if command -v steam >/dev/null 2>&1; then
  echo "Steam is already installed, skipping."
  exit 0
fi

# Play games from https://store.steampowered.com/
cd /tmp
wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb
sudo apt install -y ./steam.deb
rm steam.deb
cd -
