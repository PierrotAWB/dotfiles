#!/bin/sh

layout
setbg

x-setup &
nmcli-setup &
bluetooth-setup &
dunst &
dwmblocks &
mpd & 
unclutter &

exec dwm

