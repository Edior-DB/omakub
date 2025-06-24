# Idempotent install: check if Zoom is already installed
if command -v zoom >/dev/null 2>&1; then
  # Check if zoom is installed before running --version
  ZOOM_VERSION=$(zoom --version 2>/dev/null | head -n 1)
  echo "Zoom is already installed: $ZOOM_VERSION. Skipping install."
  exit 0
fi

# Make video calls using https://zoom.us/
cd /tmp
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb
cd -
