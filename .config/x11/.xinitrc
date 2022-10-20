#!/bin/sh

layout
setbg
settheme

x-setup &
dunst &
dwmblocks &
mpd &
unclutter &

fcitx5 &

exec dwm
