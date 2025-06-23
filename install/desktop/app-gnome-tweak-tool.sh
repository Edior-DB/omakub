if [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y gnome-tweaks
else
  sudo apt install -y gnome-tweak-tool
fi
