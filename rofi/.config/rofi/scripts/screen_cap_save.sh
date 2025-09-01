#!/usr/bin/env bash

dir="$HOME/.config/rofi"

sel="$(rofi -dmenu -theme "$dir/styles/cap_dialog_save.rasi")"

if [ -n "$sel" ]; then
  xclip -selection clipboard -t image/png -o > "$HOME/$sel.png"
fi

