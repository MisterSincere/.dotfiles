#!/bin/bash

dir="$HOME/.config/rofi/styles"

options=$(tmuxinator ls | awk '{ if (NR!=1) { print $1 } }')

selection=$(echo -e "$options" | rofi -u 1 -dmenu -i -theme "$dir/audio_out_dialog.rasi")

coproc ( alacritty -e tmuxinator start $selection )
