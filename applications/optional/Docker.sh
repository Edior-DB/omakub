# Check if lazydocker is installed
if ! command -v lazydocker >/dev/null 2>&1; then
  echo "Warning: LazyDocker is not installed. The Docker launcher will not be created."
  rm -f ~/.local/share/applications/Docker.desktop
else
  mkdir -p ~/.local/share/applications
  if [ ! -w ~/.local/share/applications ]; then
    echo "Error: Cannot write to ~/.local/share/applications."
  else
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
  fi
fi
