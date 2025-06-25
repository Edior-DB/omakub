set -x  # Debug tracing
set +e  # Do not exit on error

# Idempotent install: check if LocalSend is already installed
if command -v localsend >/dev/null 2>&1; then
  echo "LocalSend is already installed, skipping."
else
  echo "Installing LocalSend..."
  cd /tmp || { echo "Failed to cd to /tmp"; true; return; }
  LOCALSEND_VERSION=$(curl -fsSL "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\\K[^"]*')
  if [ -z "$LOCALSEND_VERSION" ]; then
    echo "Failed to fetch LocalSend version." >&2
    true
    return
  fi
  wget -O localsend.deb "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-x86-64.deb" || { echo "Failed to download LocalSend .deb"; true; return; }
  sudo apt install -y ./localsend.deb || { echo "Failed to install LocalSend .deb"; rm -f localsend.deb; true; return; }
  rm localsend.deb
  cd -
fi

echo "LocalSend install script complete."
true
