#!/bin/sh

layout
setbg

xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/x11/xresources &
xcompmgr &
nmcli-setup &
bluetooth-setup &
xbindkeys &
dwmblocks &
xset r rate 200 50 # Autorepeat rate: xset r rate <delay> <rate>

exec dwm

