# Idempotent install: check if Chrome is already installed
if command -v google-chrome >/dev/null 2>&1; then
  echo "Google Chrome is already installed, skipping."
  exit 0
fi

# Browse the web with the most popular browser. See https://www.google.com/chrome/
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
xdg-settings set default-web-browser google-chrome.desktop
cd -
