# Check if lazydocker and alacritty are installed
if ! command -v lazydocker >/dev/null 2>&1 || ! command -v alacritty >/dev/null 2>&1; then
  echo "Warning: LazyDocker or Alacritty is not installed. The Docker launcher will not be created."
  rm -f ~/.local/share/applications/Docker.desktop
  exit 0
fi
# Create the launcher if dependencies are present
cat <<EOF >~/.local/share/applications/Docker.desktop
[Desktop Entry]
Version=1.0
Name=Docker
Comment=Manage Docker containers with LazyDocker
Exec=alacritty --config-file /home/$USER/.config/alacritty/pane.toml --class=Docker --title=Docker -e lazydocker
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Docker.png
Categories=GTK;
StartupNotify=false
EOF
