#!/bin/env bash

tmp_file="/tmp/timer"

# parse timer state file
params=("" "" "" "" "")
amount_lines=0
if [ ! -f "$tmp_file" ]; then
  touch $tmp_file
else
  while read -r line; do
    params[$amount_lines]=$line
    amount_lines=$((${amount_lines} + 1))
  done <$tmp_file
fi

if (( $amount_lines >= 3 )); then
  time_passed=$(($(date +%s) - ${params[0]} - ${params[3]}))
  # if we are currently paused we need to compute current additional update time
  if (( ${params[2]} == 0 )) && (( $amount_lines > 4 )); then
    time_passed=$(( $time_passed - ($(date +%s) - ${params[4]}) ))
  fi
  seconds_left=$((${params[1]} - $time_passed))

  if (( $seconds_left <= 0 )); then
    echo "ALAAARM!"
    if [ ! -n "$ALARM_SOUND" ]; then
      ALARM_SOUND="/usr/share/sounds/freedesktop/stereo/dialog-error.oga"
    fi
    if [[ ! $ALARM_SOUND == "NONE" ]] && [ -f "$ALARM_SOUND" ]; then
      mpv $ALARM_SOUND &>/dev/null
    fi
  else
    echo "$(date -d@${seconds_left} -u +%H:%M:%S) 󰀠 "
  fi
else
  echo ""
fi
