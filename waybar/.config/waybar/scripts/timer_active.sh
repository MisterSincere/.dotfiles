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
	exit 0
fi
exit 1
