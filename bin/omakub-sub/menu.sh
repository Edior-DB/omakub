set -euo pipefail
LOGFILE="${OMAKUB_PATH:-$HOME}/omakub-error.log"

if [ -z "${OMAKUB_PATH:-}" ]; then
  echo "OMAKUB_PATH is not set. Exiting." >&2
  exit 1
fi

if [ $# -eq 0 ]; then
	SUB=$(gum choose "Theme" "Font" "Update" "Install" "Uninstall" "Manual" "Quit" --height 10 --header "" | tr '[:upper:]' '[:lower:]')
else
	SUB=$1
fi

if [ -n "$SUB" ] && [ "$SUB" != "quit" ]; then
  if [ -f "$OMAKUB_PATH/bin/omakub-sub/$SUB.sh" ]; then
    source "$OMAKUB_PATH/bin/omakub-sub/$SUB.sh" 2>>"$LOGFILE"
  else
    echo "Script $SUB.sh not found." >&2
  fi
fi
