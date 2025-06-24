# Get latest Neovim version
LATEST_NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep 'tag_name' | cut -d '"' -f4 | sed 's/^v//')
if command -v nvim >/dev/null 2>&1; then
  INSTALLED_NVIM_VERSION=$(nvim --version | head -n1 | awk '{print $2}')
else
  INSTALLED_NVIM_VERSION=""
fi

if [ "$INSTALLED_NVIM_VERSION" = "$LATEST_NVIM_VERSION" ]; then
  echo "Neovim $LATEST_NVIM_VERSION is already installed, skipping."
else
  cd /tmp
  wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
  tar -xf nvim.tar.gz
  sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
  sudo cp -R nvim-linux-x86_64/lib /usr/local/
  sudo cp -R nvim-linux-x86_64/share /usr/local/
  rm -rf nvim-linux-x86_64 nvim.tar.gz
  cd -
fi

# Install luarocks and tree-sitter-cli to resolve lazyvim :checkhealth warnings
if command -v luarocks >/dev/null 2>&1; then
  echo "luarocks is already installed, skipping."
else
  echo "Installing luarocks..."
  if ! sudo apt install -y luarocks; then
    echo "Error: Failed to install luarocks. Please check your apt sources and try again."
    exit 1
  fi
fi
if [ "$OMAKUB_OS_ID" = "ubuntu" ]; then
  sudo apt install -y tree-sitter-cli
elif [ "$OMAKUB_OS_ID" = "debian" ]; then
  # Check if tree-sitter is installed and at latest version
  if command -v tree-sitter >/dev/null 2>&1; then
    INSTALLED_TREE_SITTER_VERSION=$(tree-sitter --version 2>/dev/null | awk '{print $3}')
  else
    INSTALLED_TREE_SITTER_VERSION=""
  fi
  LATEST_TREE_SITTER_VERSION=$(curl -s https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest | grep 'tag_name' | cut -d '"' -f4 | sed 's/^v//')
  if [ "$INSTALLED_TREE_SITTER_VERSION" = "$LATEST_TREE_SITTER_VERSION" ]; then
    echo "tree-sitter $LATEST_TREE_SITTER_VERSION is already installed, skipping."
  else
    cd /tmp
    TREE_SITTER_URL=$(curl -s https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest | grep browser_download_url | grep 'tree-sitter-linux-x64.gz' | cut -d '"' -f 4 | head -n 1)
    if [ -z "$TREE_SITTER_URL" ]; then
      echo "Could not find tree-sitter CLI binary for Debian. Aborting."
      exit 1
    fi
    wget -O tree-sitter.gz "$TREE_SITTER_URL"
    gunzip tree-sitter.gz
    chmod +x tree-sitter
    sudo mv tree-sitter /usr/local/bin/tree-sitter
    cd -
  fi
fi

# Only attempt to set configuration if Neovim has never been run
if [ ! -d "$HOME/.config/nvim" ]; then
  # Use LazyVim
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  # Remove the .git folder, so you can add it to your own repo later
  rm -rf ~/.config/nvim/.git

  # Make everything match the terminal transparency
  mkdir -p ~/.config/nvim/plugin/after
  cp ~/.local/share/omakub/configs/neovim/transparency.lua ~/.config/nvim/plugin/after/

  # Default to Tokyo Night theme
  cp ~/.local/share/omakub/themes/tokyo-night/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

  # Turn off animated scrolling
  cp ~/.local/share/omakub/configs/neovim/snacks-animated-scrolling-off.lua ~/.config/nvim/lua/plugins/

  # Turn off relative line numbers
  echo "vim.opt.relativenumber = false" >>~/.config/nvim/lua/config/options.lua
fi

# Replace desktop launcher with one running inside Alacritty
if [[ -d ~/.local/share/applications ]]; then
  sudo rm -rf /usr/share/applications/nvim.desktop
  source ~/.local/share/omakub/applications/Neovim.sh
fi
