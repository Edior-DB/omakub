# Idempotent install: check if already installed
if command -v pinta >/dev/null 2>&1; then
  echo "Pinta is already installed, skipping."
  exit 0
fi

if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  sudo snap install pinta
elif [ "$OMAKUB_OS_ID" = "debian" ]; then
  # Ensure flatpak is installed
  sudo apt update -y
  sudo apt install -y flatpak
  # Add flathub remote if not present
  if ! flatpak remote-list | grep -q flathub; then
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  fi
  flatpak install -y flathub com.github.PintaProject.Pinta
  # Add alias if not present
  if ! grep -q 'alias pinta=' ~/.bashrc; then
    echo "alias pinta='flatpak run com.github.PintaProject.Pinta'" >> ~/.bashrc
    echo "Added alias for pinta to ~/.bashrc. Please restart your shell or run: source ~/.bashrc"
  fi
else
  echo "Unsupported OS for Pinta installation."
  exit 1
fi
