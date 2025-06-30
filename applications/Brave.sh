# Check if Brave is installed
if ! command -v brave-browser >/dev/null 2>&1; then
  echo "Warning: Brave browser is not installed. The Brave launcher will not be created."
  rm -f ~/.local/share/applications/Brave.desktop
else
  mkdir -p ~/.local/share/applications
  if [ ! -w ~/.local/share/applications ]; then
    echo "Error: Cannot write to ~/.local/share/applications."
  else
    # Create the launcher if Brave is present
    cat <<EOF >~/.local/share/applications/Brave.desktop
[Desktop Entry]
Version=1.0
Name=Brave
Comment=Brave Web Browser
Exec=brave-browser --new-window
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Brave.png
Categories=GTK;Network;WebBrowser;
StartupNotify=true
EOF
    # Add to dock (GNOME)
    if command -v gsettings >/dev/null 2>&1; then
      gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed "s/]$/, 'Brave.desktop']/;s/\('Brave.desktop', \)\{2,\}/'Brave.desktop', /")"
    fi
  fi
fi
