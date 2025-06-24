# Run required desktop installers
for installer in ~/.local/share/omakub/install/desktop/required/*.sh; do
  echo "Running required desktop installer: $installer"
  bash "$installer"
done

# Run core desktop installers (excluding required and optional)
for installer in ~/.local/share/omakub/install/desktop/*.sh; do
  # Skip required and optional subdirs
  [[ "$installer" == *"/required/"* || "$installer" == *"/optional/"* ]] && continue
  source $installer
done

# Logout to pickup changes
gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot
