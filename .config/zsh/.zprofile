#!/bin/zsh

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx -- -arinterval 20 -ardelay 200
fi
