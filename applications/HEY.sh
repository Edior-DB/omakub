# Check if Brave is installed
if ! command -v brave-browser >/dev/null 2>&1; then
  echo "Warning: Brave browser is not installed. The HEY launcher will not be created."
  rm -f ~/.local/share/applications/HEY.desktop
else
  # Create the launcher if Brave is present
  cat <<EOF >~/.local/share/applications/HEY.desktop
[Desktop Entry]
Version=1.0
Name=HEY
Comment=HEY Email + Calendar
Exec=brave-browser --app="https://app.hey.com/" --name=HEY --class=HEY
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/HEY.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF
fi
