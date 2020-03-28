# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/andrew/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

################## ALIASES
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'


# Lacework
alias lacework="cd ~/Lacework && ls -al"
alias lw="lacework"
alias la="lacework"
alias s="source "
alias sl="source ~/config/lwenv "
alias sl1="source ~/config/lwenv dev1"
alias sld="source ~/config/lwenv dev2"
alias sle="source ~/config/lwenv exit"
alias pf="cd ~/config && portforward.sh query-service 8080"
alias k8s="cd ~/Lacework/k8s"
alias k8=k8s
alias milkyway="cd ~/Lacework/milkyway"
alias mi="milkyway"
alias rainbow="cd ~/Lacework/rainbow"
alias ra="rainbow"
alias services="cd ~/Lacework/services"
alias qs="services"
alias cspi="cd ~/Lacework/csp-integrations"
alias csp="cspi"
alias gulp="ra && gulp --gulpfile gulpfile-dev.js"


# General
alias config="cd ~/config"
alias conf="config" 
alias scripts="cd ~/scripts"
alias mail="cd /var/mail && cat andrewwang"
alias sonar="cd /Users/andrewwang/SonarQube/sonarqube-7.8/bin/macosx-universal-64"
alias l="ls"
alias cl="clear"
alias c="cl"
alias v="vim"
alias r="ranger"
alias e="exit"


# Important directories
alias dow="cd ~/downloads && r"
alias down="dow"
alias downloads="dow"
alias doc="cd ~/documents && r"
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
alias z="source ~/.zshrc"
alias z.="vim ~/.zshrc"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
