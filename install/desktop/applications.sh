for script in ~/.local/share/omakub/applications/*.sh; do
  [ -f "$script" ] && source "$script"
done
