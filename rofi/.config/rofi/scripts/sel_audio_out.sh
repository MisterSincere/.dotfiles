#!/bin/bash

dir="$HOME/.config/rofi/styles"

options=$(pamixer --list-sinks | awk -F " \"" '{ if (NR!=1) { print substr($4, 1, length($4)-1) } }' | grep -iv hdmi)

selection=$(echo -e $options | rofi -dmenu -i -theme "$dir/audio_in_dialog.rasi")
coproc ( pamixer sink $selection )
