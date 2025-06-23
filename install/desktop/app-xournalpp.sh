# Install xournalpp (note-taking app)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y xournalpp
else
  echo "Unsupported OS for xournalpp installation."
  exit 1
fi
