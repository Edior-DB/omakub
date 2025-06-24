# Check if Google Chrome is installed
if ! command -v google-chrome >/dev/null 2>&1; then
  echo "Warning: Google Chrome is not installed. The Basecamp launcher will not be created."
  # Remove launcher if it exists
  rm -f ~/.local/share/applications/Basecamp.desktop
  exit 0
fi
# Create the launcher if Chrome is present
cat <<EOF >~/.local/share/applications/Basecamp.desktop
[Desktop Entry]
Version=1.0
Name=Basecamp
Comment=Basecamp Project Management
Exec=google-chrome --app="https://launchpad.37signals.com" --name=Basecamp --class=Basecamp
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Basecamp.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF
