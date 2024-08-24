#!/bin/bash

pamixer "$@"

msg_tag="volumebar"
volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

if [[ $mute == "true" ]]; then
  dunstify -a "change_volume" -u low -h string:x-dunst-stack-tag:$msg_tag "Volume muted"
else
  dunstify -a "change_volume" -u low -h string:x-dunst-stack-tag:$msg_tag -h int:value:"$volume" "Volume: ${volume}%"
fi

mpv /usr/share/sounds/freedesktop/stereo/message.oga &> /dev/null

