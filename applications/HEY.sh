# Check if Google Chrome is installed
if ! command -v google-chrome >/dev/null 2>&1; then
  echo "Warning: Google Chrome is not installed. The HEY launcher will not be created."
  rm -f ~/.local/share/applications/HEY.desktop
  exit 0
fi
# Create the launcher if Chrome is present
cat <<EOF >~/.local/share/applications/HEY.desktop
[Desktop Entry]
Version=1.0
Name=HEY
Comment=HEY Email + Calendar
Exec=google-chrome --app="https://app.hey.com/" --name=HEY --class=HEY
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/HEY.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF
