#!/bin/bash

# Terminate already running bar instances and wait for them to terminate
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
echo "---" | tee -a /tmp/polybar_primary_top.log /tmp/polybar_perf_bar.log /tmp/polybar_secondary_top.log
polybar -c ~/.config/polybar/config.ini primary_top >> /tmp/polybar_primary_top.log 2>&1 & disown
polybar -c ~/.config/polybar/config.ini secondary_top >> /tmp/polybar_secondary_top.log 2>&1 & disown
polybar -c ~/.config/polybar/config.ini perf_bar >> /tmp/polybar_perf_bar.log 2>&1 & disown 
