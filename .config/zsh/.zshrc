export ZSH=$ZDOTDIR/.oh-my-zsh
export UPDATE_ZSH_DAYS=13
export EDITOR='vim'

ZSH_CUSTOM=$ZDOTDIR/customizations
ZSH_THEME="agnoster"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# General
alias cl="clear"
alias c="cl"
alias config="cd ~/.config"
alias conf="config"
alias e="exit"

alias i3conf="vim ~/.config/i3/config"
alias i3.="i3conf"

alias l="ls"
alias ll="ls -l"
alias lla="ls -al"
alias lal="lla"

alias mbsync="mbsync -c "$XDG_CONFIG_HOME"/mbsync/.mbsyncrc"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias ranger='ranger --choosedir=$XDG_DATA_HOME/ranger/.rangerdir; LASTDIR=`cat $XDG_DATA_HOME/ranger/.rangerdir`; cd "$LASTDIR"'
alias r="ranger"
alias ra="r"

alias todo="vim ~/Documents/TODO"
alias v="vim"
alias v.="vim $XDG_CONFIG_HOME/vim/.vimrc"
alias xre="vim $XDG_CONFIG_HOME/Xresources"

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
alias mimetype="xdg-mime query filetype"
alias mime=mimetype


[ -f $XDG_CONFIG_HOME/fzf/.fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/.fzf.zsh
