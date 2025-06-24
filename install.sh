# Exit immediately if a command exits with a non-zero status and print errors clearly
set -eEuo pipefail

# Initialize for error reporting
current_command=""
last_command=""

# Improved error reporting: show the failed command and its exit code for easier troubleshooting
function omakub_error_trap {
  local exit_code=$?
  echo -e "\nOmakub installation failed!\n  Command: $last_command\n  Exit code: $exit_code\n  You can retry by running: source ~/.local/share/omakub/install.sh"
  while true; do sleep 1; done
}
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'omakub_error_trap' ERR

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omakub/install/check-version.sh

# Ask for required tools and user choices
echo "Get ready to make a few choices..."
source ~/.local/share/omakub/install/terminal/required/app-gum.sh >/dev/null
source ~/.local/share/omakub/install/first-run-choices.sh
source ~/.local/share/omakub/install/identification.sh

# Only install desktop software and tweaks if running GNOME
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  # Prevent sleep/lock during installation
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  gsettings set org.gnome.desktop.session idle-delay 0

  echo "Installing terminal and desktop tools..."

  # Install terminal tools
  source ~/.local/share/omakub/install/terminal.sh

  # Install desktop tools and tweaks
  source ~/.local/share/omakub/install/desktop.sh

  # Restore normal idle and lock settings
  gsettings set org.gnome.desktop.screensaver lock-enabled true
  gsettings set org.gnome.desktop.session idle-delay 300
else
  # If not running GNOME, check and offer to install GNOME after terminal tools
  echo "Only installing terminal tools..."
  source ~/.local/share/omakub/install/terminal.sh

  echo "You can now optionally install GNOME and desktop apps."
  source ~/.local/share/omakub/install/check-gnome.sh
fi
