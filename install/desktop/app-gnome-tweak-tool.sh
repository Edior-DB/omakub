if [ "$OMAKUB_OS_ID" = "debian" ]; then
  if ! dpkg -s gnome-tweaks >/dev/null 2>&1; then
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y gnome-tweaks
  else
    echo "gnome-tweaks is already installed."
  fi
elif [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  if ! dpkg -s gnome-tweak-tool >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y gnome-tweak-tool
  else
    echo "gnome-tweak-tool is already installed."
  fi
else
  echo "Unsupported OS: $OMAKUB_OS_ID. GNOME Tweaks install skipped." >&2
fi
