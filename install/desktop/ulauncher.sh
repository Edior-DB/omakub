if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ "$ID" = "ubuntu" ]; then
    gpg --keyserver keyserver.ubuntu.com --recv 0xfaf1020699503176
    gpg --export 0xfaf1020699503176 | sudo tee /usr/share/keyrings/ulauncher-archive-keyring.gpg >/dev/null
    echo "deb [signed-by=/usr/share/keyrings/ulauncher-archive-keyring.gpg] http://ppa.launchpad.net/agornostal/ulauncher/ubuntu noble main" | sudo tee /etc/apt/sources.list.d/ulauncher-noble.list
    sudo apt update -y
    sudo apt install -y ulauncher
  elif [ "$ID" = "debian" ]; then
    # Use official .deb for Debian
    cd /tmp
    ULVER=$(curl -s https://api.github.com/repos/Ulauncher/Ulauncher/releases/latest | grep 'tag_name' | cut -d\" -f4)
    wget -O ulauncher.deb "https://github.com/Ulauncher/Ulauncher/releases/download/$ULVER/ulauncher_${ULVER#v}_all.deb"
    sudo apt install -y ./ulauncher.deb
    rm ulauncher.deb
    cd -
  fi
fi

# Start ulauncher to have it populate config before we overwrite
mkdir -p ~/.config/autostart/
cp ~/.local/share/omakub/configs/ulauncher.desktop ~/.config/autostart/ulauncher.desktop
gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults
cp ~/.local/share/omakub/configs/ulauncher.json ~/.config/ulauncher/settings.json
