# Check if fastfetch and alacritty are installed
if ! command -v fastfetch >/dev/null 2>&1 || ! command -v alacritty >/dev/null 2>&1; then
  echo "Warning: Fastfetch or Alacritty is not installed. The About launcher will not be created."
  rm -f ~/.local/share/applications/About.desktop
else
  # Create the launcher if dependencies are present
  cat <<EOF >~/.local/share/applications/About.desktop
[Desktop Entry]
Version=1.0
Name=About
Comment=System information from Fastfetch
Exec=alacritty --config-file /home/$USER/.config/alacritty/pane.toml --class=About --title=About -e bash -c 'fastfetch; read -n 1 -s'
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Ubuntu.png
Categories=GTK;
StartupNotify=false
EOF
fi
