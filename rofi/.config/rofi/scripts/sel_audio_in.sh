#!/bin/bash

dir="$HOME/.config/rofi/styles"

options=$(pamixer --list-sources | awk -F " \"" '{ if (NR!=1) { print substr($4, 1, length($4)-1) } }')

selection=$(echo -e "$options" | rofi -u 1 -dmenu -i -theme "$dir/audio_out_dialog.rasi")

selected_sink=$(pamixer --list-sources | grep "$selection" | awk '{ print $1 }')
coproc ( pamixer --sink $selected_sink )
