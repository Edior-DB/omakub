# Alacritty launcher
# Alacritty is required, so no need to check for it
mkdir -p ~/.local/share/applications
if [ ! -w ~/.local/share/applications ]; then
  echo "Error: Cannot write to ~/.local/share/applications."
else
  cat <<EOF >~/.local/share/applications/Alacritty.desktop
[Desktop Entry]
Version=1.0
Name=Alacritty
Comment=Alacritty Terminal Emulator
Exec=alacritty
Terminal=false
Type=Application
Icon=alacritty
Categories=GTK;System;TerminalEmulator;
StartupNotify=false
EOF
fi
