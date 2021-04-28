#!/bin/sh

layout
setbg

xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/x11/xresources &
xcompmgr -cfF -D5 > /dev/null 2>&1 &
nmcli-setup &
bluetooth-setup &
dunst &
xbindkeys &
dwmblocks &
xset r rate 200 50 # Autorepeat rate: xset r rate <delay> <rate>

exec dwm

