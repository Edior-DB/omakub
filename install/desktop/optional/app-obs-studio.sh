# OBS Studio is a screen recording application that allows you to capture both display and webcam in the same recording
# Install OBS Studio
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y obs-studio
else
  echo "Unsupported OS for OBS Studio installation."
  exit 1
fi
