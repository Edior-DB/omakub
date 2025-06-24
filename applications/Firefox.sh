# Check if Firefox is installed
if ! command -v firefox >/dev/null 2>&1; then
  echo "Warning: Firefox is not installed. The Firefox launcher will not be created."
  rm -f ~/.local/share/applications/Firefox.desktop
else
  mkdir -p ~/.local/share/applications
  if [ ! -w ~/.local/share/applications ]; then
    echo "Error: Cannot write to ~/.local/share/applications."
  else
    cat <<EOF >~/.local/share/applications/Firefox.desktop
[Desktop Entry]
Version=1.0
Name=Firefox
Comment=Browse the Web
Exec=firefox --new-window
Terminal=false
Type=Application
Icon=firefox
Categories=GTK;Network;WebBrowser;
StartupNotify=true
EOF
  fi
fi
