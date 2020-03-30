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



# General
alias cl="clear"
alias c="cl"
alias config="cd ~/.config"
alias conf="config"
alias e="exit"

alias i3conf="vim ~/.config/i3/config"

alias l="ls"
alias ll="ls -l"
alias lla="ls -al"
alias lal="lla"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias r="ranger"
alias ra="r"

alias todo="vim ~/Documents/TODO"
alias v="vim"
alias v.="vim .vimrc"


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
alias z="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias z.="vim $XDG_CONFIG_HOME/zsh/.zshrc"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
