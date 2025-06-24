# Install VLC
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y vlc
else
  echo "Unsupported OS for VLC installation."
  exit 1
fi
