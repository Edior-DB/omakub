# Needed for all installers
sudo apt update -y
sudo apt upgrade -y

# Install curl, git, unzip (core tools)
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y curl git unzip
else
  echo "Unsupported OS for core tools installation."
  exit 1
fi

# Run terminal installers
for installer in ~/.local/share/omakub/install/terminal/*.sh; do source $installer; done
