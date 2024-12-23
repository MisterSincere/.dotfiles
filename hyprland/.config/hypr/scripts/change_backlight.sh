#!/bin/bash

brightnessctl set $@

msg_tag="brightnessbar"
brightness=$(($(brightnessctl g) * 100 / $(brightnessctl m)))
screen_off="false"

if [[ $mute == "true" ]]; then
  dunstify -a "change_brightness" -u low -h string:x-dunst-stack-tag:$msg_tag "Volume muted"
else
  dunstify -a "change_brightness" -u low -h string:x-dunst-stack-tag:$msg_tag -h int:value:"$brightness" "Brightness: ${brightness}%"
fi

