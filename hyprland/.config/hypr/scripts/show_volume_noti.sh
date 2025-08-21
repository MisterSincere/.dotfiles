#!/bin/bash
msg_tag="volumebar"
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F " " '{ print $2 * 100 }')
mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F " " '{ print $3 }')

if [[ $mute == "[MUTED]" ]]; then
  dunstify -a "change_volume" -u low -h string:x-dunst-stack-tag:$msg_tag "Volume muted"
else
  dunstify -a "change_volume" -u low -h string:x-dunst-stack-tag:$msg_tag -h int:value:"$volume" "Volume: ${volume}%"
fi

mpv /usr/share/sounds/freedesktop/stereo/message.oga
