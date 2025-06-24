choice=$(gum choose {7..14} "<< Back" --height 11 --header "Choose your terminal font size")

if [[ $choice =~ ^[0-9]+$ ]]; then
	# Use portable sed for both GNU and BSD/macOS
	sed -i.bak -E "s/^\s*size = .*/size = $choice/" ~/.config/alacritty/font-size.toml
	source $OMAKUB_PATH/bin/omakub-sub/font-size.sh
else
	source $OMAKUB_PATH/bin/omakub-sub/font.sh
fi
