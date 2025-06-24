# Idempotent install: check if Minecraft Launcher is already installed
if command -v minecraft-launcher >/dev/null 2>&1; then
  echo "Minecraft Launcher is already installed, skipping."
  exit 0
fi

sudo apt install -y openjdk-8-jdk

cd /tmp
wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install -y ./Minecraft.deb
rm Minecraft.deb
cd -
