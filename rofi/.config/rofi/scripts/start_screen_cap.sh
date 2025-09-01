#!/usr/bin/env bash

dir="$HOME/.config/rofi/styles"

rofi -show "screen_cap" -modi "screen_cap:~/.config/rofi/scripts/screen_cap.sh" -i -theme "$dir/cap_dialog.rasi"
