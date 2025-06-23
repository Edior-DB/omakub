# Install Typora (markdown editor)
if ! command -v typora >/dev/null 2>&1; then
  wget -qO - https://typora.io/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc
  sudo add-apt-repository -y 'deb https://typora.io/linux ./'
  sudo apt update -y
  sudo apt install -y typora
else
  echo "typora is already installed, skipping."
fi

# Add iA Typora theme
mkdir -p ~/.config/Typora/themes
cp ~/.local/share/omakub/configs/typora/ia_typora.css ~/.config/Typora/themes/
cp ~/.local/share/omakub/configs/typora/ia_typora_night.css ~/.config/Typora/themes/
