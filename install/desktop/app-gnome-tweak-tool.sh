if [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y gnome-tweaks
elif [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  sudo apt install -y gnome-tweak-tool
else
  echo "Unsupported OS: $OMAKUB_OS_ID. GNOME Tweaks install skipped." >&2
  exit 1
fi
