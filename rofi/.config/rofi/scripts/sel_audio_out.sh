#!/bin/bash

dir="$HOME/.config/rofi/styles"

# filter audio outputs down to readable names
# @note don't show hdmi outputs
all_options=$(pamixer --list-sinks)
options=$(echo -e "${all_options}" | awk -F " \"" '{ if (NR!=1) { print substr($4, 1, length($4)-1) } }' | grep -iv hdmi)

# give options to rofi
selection=$(echo -e "${options}" | rofi -dmenu -i -theme "$dir/audio_in_dialog.rasi")
coproc ( pamixer --sink $selection )
