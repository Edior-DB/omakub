# Idempotent install: check if already installed
if command -v pinta >/dev/null 2>&1; then
  echo "Pinta is already installed, skipping."
  exit 0
fi

if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  sudo snap install pinta
elif [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt update -y
  sudo apt install -y pinta
else
  echo "Unsupported OS for Pinta installation."
  exit 1
fi
