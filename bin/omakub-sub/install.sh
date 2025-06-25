set -euo pipefail

if [ -z "${OMAKUB_PATH:-}" ]; then
  echo "OMAKUB_PATH is not set. Exiting." >&2
  exit 1
fi

CHOICES=(
  "Dev Editor        Install alternative programming editors"
  "Dev Language      Install programming language environment"
  "Dev Database      Install development database in Docker"
  "1password         Manage your passwords securely across devices"
  "Audacity          Record and edit audio"
  "ASDControl        Set brightness on Apple Studio and XDR displays"
  "Chrome            Browser"
  "Dropbox           Sync files across computers with ease"
  "Gimp              Image manipulation tool ala Photoshop"
  "Geekbench         CPU benchmaking tool"
  "Mainline Kernels  Install newer Linux kernels than Ubuntu defaults"
  "Minecraft         Everyone's favorite blocky building game"
  "OBS Studio        Record screencasts with inputs from both display + webcam"
  "Ollama            Run LLMs, like Meta's Llama3, locally"
  "Retroarch         Play retro games"
  "Spotify           Stream music from the world's most popular service"
  "Steam             Play games from Valve's store"
  "Tailscale         Mesh VPN based on WireGuard and with Magic DNS"
  "VirtualBox        Virtual machines to run Windows/Linux"
  "Zoom              Attend and host video chat meetings"
  "Web Apps          Install web apps with their own icon and shell"
  "> All             Re-run any of the default installers"
  "<< Back           "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 25 --header "Install application")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
  echo ""
elif [[ "$CHOICE" == "> All"* ]]; then
  INSTALLER_FILE=$(gum file $OMAKUB_PATH/install)
  if [[ -n "$INSTALLER_FILE" ]]; then
    gum confirm "Run installer?" &&
    source "$INSTALLER_FILE" &&
    gum spin --spinner globe --title "Install completed!" -- sleep 3
  fi
else
  if [ "$OMAKUB_OS_ID" = "debian" ]; then
    INSTALLER=$(echo "$CHOICE" | awk '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
  else
    INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
  fi
  case "$INSTALLER" in
    "dev-editor") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/install-dev-editor.sh" ;;
    "web-apps") INSTALLER_FILE="$OMAKUB_PATH/install/desktop/optional/select-web-apps.sh" ;;
    "dev-language") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/select-dev-language.sh" ;;
    "dev-database") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/select-dev-storage.sh" ;;
    "ollama") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/app-ollama.sh" ;;
    "tailscale") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/app-tailscale.sh" ;;
    "geekbench") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/app-geekbench.sh" ;;
    *) INSTALLER_FILE="$OMAKUB_PATH/install/desktop/optional/app-$INSTALLER.sh" ;;
  esac

  if [ -f "$INSTALLER_FILE" ]; then
    echo "Running installer: $INSTALLER_FILE"
    source "$INSTALLER_FILE" && gum spin --spinner globe --title "Install completed!" -- sleep 3
  else
    echo "Installer $INSTALLER_FILE not found." >&2
  fi
fi

clear
source $OMAKUB_PATH/bin/omakub
