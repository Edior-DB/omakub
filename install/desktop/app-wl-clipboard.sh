# Provides a system clipboard interface for Neovim under Wayland

# Install wl-clipboard (Wayland clipboard tool)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install wl-clipboard
else
  echo "Unsupported OS for wl-clipboard installation."
  exit 1
fi
