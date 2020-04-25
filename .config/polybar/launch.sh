#!/usr/bin/env bash

# Script to launch polybar bars


# Terminate already running bar instances
killall -q polybar

# Source xresources on startup
xrdb $HOME/.config/Xresources

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar on every monitor
for m in $(polybar --list-monitors | cut -d":" -f1); do
  echo $m
  if [ ! -z "$(polybar --list-monitors | awk -v m="$m" '$0 ~ m && /primary/')" ]; then
    MONITOR=$m polybar --reload bar-primary &
    echo primary
  else
    MONITOR=$m polybar --reload bar-secondary &
    echo secondary
  fi
done

echo "Bars launched..."
