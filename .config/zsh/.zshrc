#export UPDATE_ZSH_DAYS=13
export EDITOR='vim'

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd

# vi mode
bindkey -v
export KEYTIMEOUT=1

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^K" kill-line
bindkey "^D" delete-char

bindkey "^F" vi-forward-blank-word
bindkey "^L" vi-forward-char
bindkey "^B" vi-backward-blank-word
bindkey "^H" vi-backward-char

bindkey "^Z" undo

bindkey "^P" clear-screen


# Use vim keys in tab complete menu:
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'j' vi-down-line-or-history
 
# Disable `XOFF`, so <C-s> works in Vim
stty -ixon

# General
alias cl="clear"
alias c="cl"
alias config="cd $XDG_CONFIG_HOME"
alias conf="config"
alias clion="$XDG_CONFIG_HOME/JetBrains/CLion2020.1/bin/clion.sh"
alias d="cd $XDG_CONFIG_HOME/dwm"
alias d.="cd $XDG_CONFIG_HOME/dwm && sudo vim config.h" 
alias e="exit"
alias i3conf="vim ~/.config/i3/config"
alias i3.="i3conf"
alias l="ls"
alias l.="cd $XDG_CONFIG_HOME/lf && vim lfrc"
alias lf='lf -last-dir-path=$XDG_DATA_HOME/lf/.lfdir; LASTDIR=`cat $XDG_DATA_HOME/lf/.lfdir`; cd "$LASTDIR"'
alias ll="ls -l"
alias lla="ls -al"
alias lal="lla"
alias linux="ssh -Y a99wang@linux.student.cs.uwaterloo.ca"
alias mbsync="mbsync -c "$XDG_CONFIG_HOME"/mbsync/.mbsyncrc"
alias m="ncmpcpp"
alias newsboat="newsboat -C $XDG_CONFIG_HOME/newsboat/config"
alias note="vim ~/documents/notes/scratchpad"
alias pdb="pdb3.6"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias ranger='ranger --choosedir=$XDG_DATA_HOME/ranger/.rangerdir; LASTDIR=`cat $XDG_DATA_HOME/ranger/.rangerdir`; cd "$LASTDIR"'
alias r="lf"
alias sp='spotifyd -u andrewwang298 -p $(pass spotify) && spt'
alias tlm="tllocalmgr" #TeX Live Manager
alias todo="vim ~/documents/notes/todo"
alias unlock-key="pass mutt-wizard-personal > /dev/null"
alias uk="unlock-key"
alias v="vim"
alias v.="vim $XDG_CONFIG_HOME/vim/vimrc"
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
alias scripts="cd ~/.local/bin"

# Git
alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gc="git commit"
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
alias gs="git status"

# zsh
alias z="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias z.="vim $XDG_CONFIG_HOME/zsh/.zshrc"

# misc
alias dfh="df -h | egrep 'Filesystem|/dev/nvme0n1p4'"
alias fan="sensors | egrep 'Left|Right'"
alias fans="fan"
alias mimetype="xdg-mime query filetype"
alias mime=mimetype
alias mp="mbsync personal"
alias sinks="pactl list short sinks"
alias sink="sinks"
alias temp="sudo tlp stat -t"
alias xbindkeys="xbindkeys -f $XDG_CONFIG_HOME/xbindkeysrc"

[ -f $XDG_CONFIG_HOME/fzf/shell/key-bindings.zsh ] && source $XDG_CONFIG_HOME/fzf/shell/key-bindings.zsh
[ -f $XDG_CONFIG_HOME/fzf/shell/completion.zsh ] && source $XDG_CONFIG_HOME/fzf/shell/completion.zsh
