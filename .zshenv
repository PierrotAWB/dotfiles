#! /bin/zsh

export PATH="/usr/local/texlive/2023/bin/universal-darwin:${PATH}"

export PATH="/opt/homebrew/opt/util-linux/bin:${PATH}"
export PATH="/opt/homebrew/opt/util-linux/sbin:$PATH"

[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"
