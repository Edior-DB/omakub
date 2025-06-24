set -e

# Early checks for required commands and OS
if ! command -v sudo >/dev/null 2>&1; then
    echo "$(tput setaf 1)Error: 'sudo' command not found. Please install sudo and ensure it is in your PATH."
    echo "Installation stopped."
    exit 1
fi



ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Omakub is for fresh Ubuntu 24.04+ or Debian 12+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

if ! groups "$USER" | grep -qw sudo; then
    echo "$(tput setaf 1)Error: Your user ($USER) is not in the 'sudo' group."
    echo "On Debian 12+, you must add your user to the 'sudo' group and re-login before running this installer."
    echo "Switch to root with: su -"
    echo "Then run: /sbin/usermod -aG sudo <your-username>"
    echo "(Replace <your-username> with your actual username, e.g. '$(logname)' if unsure)"
    echo "After that, log out and log back in as your user, then re-run the installer."
    echo "For some weird reason, you might also need to reboot your system."
    echo "Installation stopped."
    exit 1
fi

sudo apt-get install -y git >/dev/null

echo "Cloning Omakub..."
rm -rf ~/.local/share/omakub
git clone https://github.com/Edior-DB/omakub.git ~/.local/share/omakub >/dev/null
if [[ $OMAKUB_REF != "master" ]]; then
	cd ~/.local/share/omakub
	git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/omakub/install.sh
