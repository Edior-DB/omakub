# Check if alacritty is installed
if ! command -v alacritty >/dev/null 2>&1; then
  echo "Warning: Alacritty is not installed. The Omakub launcher will not be created."
  rm -f ~/.local/share/applications/Omakub.desktop
else
  # Create the launcher if Alacritty is present
  cat <<EOF >~/.local/share/applications/Omakub.desktop
[Desktop Entry]
Version=1.0
Name=Omakub
Comment=Omakub Controls
Exec=alacritty --config-file /home/$USER/.config/alacritty/pane.toml --class=Omakub --title=Omakub -e omakub
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Omakub.png
Categories=GTK;
StartupNotify=false
EOF
fi
