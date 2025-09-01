#!/usr/bin/env bash

dir="$HOME/.config/rofi/"
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

sel="$(rofi -dmenu -theme "$dir/styles/timer_dialog.rasi")"

shopt -s nocasematch
if [[ $sel == "stop" ]] || [[ $sel == "s" ]] || [[ $sel == "q" ]]; then
  echo "" > $tmp_file
elif [[ $sel == "pause" ]] || [[ $sel == "p" ]]; then
  if (( $amount_lines > 3 )) && (( ${params[2]} == 1 )); then
    echo ${params[0]} > $tmp_file   # timer start time in epoch
    echo ${params[1]} >> $tmp_file  # absolute timer run time
    echo "0" >> $tmp_file           # 0 indicates pause status
    echo ${params[3]} >> $tmp_file  # pause time up to tis point
    echo $(date +%s) >> $tmp_file   # pause start time at index 4
  fi
elif [[ $sel == "continue" ]] || [[ $sel == "c" ]]; then
  if (( $amount_lines > 4 )) && (( ${params[2]} == 0 )); then
    echo ${params[0]} > $tmp_file   # timer start time in epoch
    echo ${params[1]} >> $tmp_file  # absolute timer run time (in secs)
    echo "1" >> $tmp_file           # 1 indicates we are running again
    # new pause time: old pause time + time_passed
    echo $(( ${params[3]} + ($(date +%s) - ${params[4]}) )) >> $tmp_file
  fi
elif [ -n "$sel" ]; then
  start_time=$(date +%s)
  echo $start_time > $tmp_file
  echo $(($sel)) >> $tmp_file
  echo "1" >> $tmp_file
  echo "0" >> $tmp_file
fi

