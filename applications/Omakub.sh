# Omakub launcher (no dependency check needed)
mkdir -p ~/.local/share/applications
if [ ! -w ~/.local/share/applications ]; then
  echo "Error: Cannot write to ~/.local/share/applications."
else
  # Create the launcher
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
