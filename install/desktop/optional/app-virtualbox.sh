# Virtualbox allows you to run VMs for other flavors of Linux or even Windows
# See https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview
# for a guide on how to run Ubuntu inside it.

# Install VirtualBox and extension pack
if [ "$OMAKUB_OS_ID" = "ubuntu" ] || [ "$OMAKUB_OS_ID" = "debian" ]; then
  sudo apt install -y virtualbox virtualbox-ext-pack
  sudo usermod -aG vboxusers ${USER}
else
  echo "Unsupported OS for VirtualBox installation."
  exit 1
fi
