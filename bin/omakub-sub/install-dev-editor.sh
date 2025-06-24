CHOICES=(
  "Cursor            AI Code Editor"
  "Doom Emacs        Emacs framework with curated list of packages"
  "Neovim            Modern modal code editor"
  "RubyMine          IntelliJ's commercial Ruby editor"
  "VSCode            Popular open-source code editor"
  "Windsurf          Another AI Code Editor"
  "Zed               Fast all-purpose editor"
  "<< Back           "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 10 --header "Install editor")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
  # Don't install anything
  echo ""
else
  INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
  case "$INSTALLER" in
    "neovim") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/app-neovim.sh" ;;
    "vscode") INSTALLER_FILE="$OMAKUB_PATH/install/desktop/optional/app-vscode.sh" ;;
    *) INSTALLER_FILE="$OMAKUB_PATH/install/desktop/optional/app-$INSTALLER.sh" ;;
  esac

  source $INSTALLER_FILE && gum spin --spinner globe --title "Install completed!" -- sleep 3
fi

clear
source $OMAKUB_PATH/bin/omakub-sub/header.sh
source $OMAKUB_PATH/bin/omakub-sub/install.sh
