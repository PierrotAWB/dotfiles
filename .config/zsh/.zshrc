export ZSH=$ZDOTDIR/.oh-my-zsh
export UPDATE_ZSH_DAYS=13
export EDITOR='vim'

ZSH_CUSTOM=$ZDOTDIR/custom
ZSH_THEME="agnoster"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Disable `XOFF`, so <C-s> works in Vim
stty -ixon

# General
alias abook="abook --datafile $XDG_CONFIG_HOME/abook/addressbook"
alias cl="clear"
alias c="cl"
alias config="cd ~/.config"
alias conf="config"
alias clion="$XDG_CONFIG_HOME/JetBrains/CLion2020.1/bin/clion.sh"
alias e="exit"
alias i3conf="vim ~/.config/i3/config"
alias i3.="i3conf"
alias l="ls"
alias ll="ls -l"
alias lla="ls -al"
alias lal="lla"
alias linux="ssh -Y a99wang@linux.student.cs.uwaterloo.ca"
alias mbsync="mbsync -c "$XDG_CONFIG_HOME"/mbsync/.mbsyncrc"
alias newsboat="newsboat -C $XDG_CONFIG_HOME/newsboat/config"
alias note="vim ~/Documents/NOTE"
alias pdb="pdb3.6"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias ranger='ranger --choosedir=$XDG_DATA_HOME/ranger/.rangerdir; LASTDIR=`cat $XDG_DATA_HOME/ranger/.rangerdir`; cd "$LASTDIR"'
alias r="ranger"
alias ra="r"
alias sp='spotifyd -u andrewwang298 -p $(pass spotify) && spt'
alias todo="vim ~/Documents/TODO"
alias v="vim"
alias v.="vim $XDG_CONFIG_HOME/vim/.vimrc"
alias xre="vim $XDG_CONFIG_HOME/Xresources"
alias youtube-dl="youtube-dl --config-location $XDG_CONFIG_HOME/youtube-dl/config"
alias yd="youtube-dl"

# Common directories
alias books="cd ~/Documents/Books"
alias dow="cd ~/Downloads"
alias down="dow"
alias downloads="dow"
alias dl="dow"
alias doc="cd ~/Documents"
alias documents="doc"
alias scripts="cd ~/.bin/scripts"


# Kubernetes
alias kgp="kubectl get pods"
alias kt="kubetail"


# R bindings
alias RR="R --no-save < "


# Git
alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gcp="git cherry-pick"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"

alias gd1="git diff HEAD^..HEAD"
alias gd2="git diff HEAD^^..HEAD"
alias gd3="git diff HEAD^^^..HEAD"
alias gd4="git diff HEAD^^^^..HEAD"

alias gf="git fetch"
alias gl="git log"
alias gm="git merge"
alias gmt="git mergetool"
alias gpl="git pull"
alias gpu="git push"
alias grb="git rebase"
alias grl="git reflog"
alias grev="git revert"
alias gs="gst"


# zsh
alias z="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias z.="vim $XDG_CONFIG_HOME/zsh/.zshrc"


# misc
alias dfh="df -h | egrep 'Filesystem|/dev/nvme0n1p5'"
alias fan="sensors | egrep 'Left|Right'"
alias fans="fan"
alias mimetype="xdg-mime query filetype"
alias mime=mimetype
alias mp="mbsync personal"
alias sinks="pactl list short sinks"
alias sink="sinks"
alias temp="sudo tlp stat -t"

# Autorepeat rate: xset r rate <delay> <rate>
xset r rate 200 50

[ -f $XDG_CONFIG_HOME/fzf/.fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/.fzf.zsh




