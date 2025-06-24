# Check if Google Chrome is installed
if ! command -v google-chrome >/dev/null 2>&1; then
  echo "Warning: Google Chrome is not installed. The WhatsApp launcher will not be created."
  rm -f ~/.local/share/applications/WhatsApp.desktop
else
  # Create the launcher if Chrome is present
  cat <<EOF >~/.local/share/applications/WhatsApp.desktop
[Desktop Entry]
Version=1.0
Name=WhatsApp
Comment=WhatsApp Messenger
Exec=google-chrome --app="https://web.whatsapp.com" --name=WhatsApp --class=Whatsapp
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/WhatsApp.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF
fi
