# Idempotent install: check if Minecraft Launcher is already installed
# Check if minecraft-launcher is installed before running --version
if command -v minecraft-launcher >/dev/null 2>&1; then
  MINECRAFT_VERSION=$(minecraft-launcher --version 2>/dev/null | head -n 1)
  echo "Minecraft Launcher is already installed: $MINECRAFT_VERSION. Skipping install."
  exit 0
fi

sudo apt install -y openjdk-8-jdk

cd /tmp
wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install -y ./Minecraft.deb
rm Minecraft.deb
cd -
