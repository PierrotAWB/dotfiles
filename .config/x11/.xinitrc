#!/bin/sh

layout
setbg

x-setup &
dunst &
dwmblocks &
mpd & 
unclutter &

exec dwm
