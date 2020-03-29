export ZSH="/home/andrew/.oh-my-zsh"
export UPDATE_ZSH_DAYS=13
export EDITOR='vim'

ZSH_CUSTOM=$ZDOTDIR/customizations
ZSH_THEME="agnoster"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'


# General
alias cl="clear"
alias c="cl"
alias e="exit"

alias i3conf="vim ~/.config/i3/config"

alias l="ls"
alias ll="ls -l"
alias lla="ls -al"
alias lal="lla"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias r="ranger"
alias todo="vim ~/Documents/TODO"
alias v="vim"


# Important directories
alias dow="cd ~/Downloads && r"
alias down="dow"
alias downloads="dow"
alias doc="cd ~/Documents && r"
alias documents="doc"


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
alias z="source ~/.config/zsh/.zshrc"
alias z.="vim ~/.config/zsh/.zshrc"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
