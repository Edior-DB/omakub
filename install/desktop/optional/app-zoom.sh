# Idempotent install: check if Zoom is already installed
if command -v zoom >/dev/null 2>&1; then
  echo "Zoom is already installed, skipping."
  exit 0
fi

# Make video calls using https://zoom.us/
cd /tmp
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb
cd -
