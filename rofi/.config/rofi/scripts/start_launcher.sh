#!/usr/bin/env bash

dir="$HOME/.config/rofi/styles"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"launcher" -sorting-method fzf -sort
