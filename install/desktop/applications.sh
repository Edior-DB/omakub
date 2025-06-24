for script in ~/.local/share/omakub/applications/*.sh ~/.local/share/omakub/applications/optional/*.sh; do
  [ -f "$script" ] && source "$script"
done
