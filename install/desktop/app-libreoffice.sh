# Install LibreOffice
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y libreoffice
else
  echo "Unsupported OS for LibreOffice installation."
  exit 1
fi
