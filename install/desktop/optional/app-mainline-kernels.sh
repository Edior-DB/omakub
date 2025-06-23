# Install mainline (kernel tool, Ubuntu only)
if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  sudo add-apt-repository -y ppa:cappelikan/ppa
  sudo apt update -y
  sudo apt install -y mainline
else
  echo "Mainline kernel tool is only supported on Ubuntu."
fi
