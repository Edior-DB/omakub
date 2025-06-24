# Check if btop is installed
if ! command -v btop >/dev/null 2>&1; then
  echo "Warning: btop is not installed. The Activity launcher will not be created."
  rm -f ~/.local/share/applications/Activity.desktop
else
  mkdir -p ~/.local/share/applications
  if [ ! -w ~/.local/share/applications ]; then
    echo "Error: Cannot write to ~/.local/share/applications."
  else
    cat <<EOF >~/.local/share/applications/Activity.desktop
[Desktop Entry]
Version=1.0
Name=Activity
Comment=System activity from btop
Exec=alacritty --config-file /home/$USER/.config/alacritty/btop.toml --class=Activity --title=Activity -e btop
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Activity.png
Categories=GTK;
StartupNotify=false
EOF
  fi
fi
