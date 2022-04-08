#!/bin/sh

layout
setbg
settheme

x-setup &
dunst &
dwmblocks &
mpd & 
unclutter &

exec dwm
