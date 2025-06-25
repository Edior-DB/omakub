# Idempotent install: check if LocalSend is already installed
if command -v localsend >/dev/null 2>&1; then
  echo "LocalSend is already installed, skipping."
else
  echo "Installing LocalSend..."
  cd /tmp || { echo "Failed to cd to /tmp"; exit 1; }
  LOCALSEND_VERSION=$(curl -fsSL "https://api.github.com/repos/localsend/localsend/releases/latest" | sed -n 's/.*"tag_name": "v\([^"\)]*\)".*/\1/p')
  if [ -z "$LOCALSEND_VERSION" ]; then
    echo "Failed to fetch LocalSend version." >&2
    exit 1
  fi
  wget -O localsend.deb "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-x86-64.deb" || { echo "Failed to download LocalSend .deb"; exit 1; }
  sudo apt install -y ./localsend.deb || { echo "Failed to install LocalSend .deb"; rm -f localsend.deb; exit 1; }
  rm -f localsend.deb
  cd -
fi

echo "LocalSend install script complete."
