# Check if gnome-control-center is installed
if ! command -v gnome-control-center >/dev/null 2>&1; then
  echo "Warning: GNOME Settings (gnome-control-center) is not installed. The Settings launcher will not be created."
  rm -f ~/.local/share/applications/Settings.desktop
else
  mkdir -p ~/.local/share/applications
  if [ ! -w ~/.local/share/applications ]; then
    echo "Error: Cannot write to ~/.local/share/applications."
  else
    cat <<EOF >~/.local/share/applications/Settings.desktop
[Desktop Entry]
Version=1.0
Name=Settings
Comment=GNOME Settings
Exec=gnome-control-center
Terminal=false
Type=Application
Icon=preferences-system
Categories=Settings;DesktopSettings;
StartupNotify=true
EOF
  fi
fi
