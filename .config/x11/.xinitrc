#!/bin/sh

layout
setbg

x-setup &
nmcli-setup &
bluetooth-setup &
dunst &
dwmblocks &
mpd & 
xset r rate 200 50 & # Autorepeat rate: xset r rate <delay> <rate>
unclutter &

exec dwm

