# Check if nvim and alacritty are installed
if ! command -v nvim >/dev/null 2>&1 || ! command -v alacritty >/dev/null 2>&1; then
  echo "Warning: Neovim (nvim) or Alacritty is not installed. The Neovim launcher will not be created."
  rm -f ~/.local/share/applications/Neovim.desktop
else
  # Create the launcher if dependencies are present
  cat <<EOF >~/.local/share/applications/Neovim.desktop
[Desktop Entry]
Version=1.0
Name=Neovim
Comment=Edit text files
Exec=alacritty --config-file /home/$USER/.config/alacritty/pane.toml --class=Neovim --title=Neovim -e nvim %F
Terminal=false
Type=Application
Icon=nvim
Categories=Utilities;TextEditor;
StartupNotify=false
EOF
fi
