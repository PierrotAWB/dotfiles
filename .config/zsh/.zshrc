autoload -U compinit; compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

export EDITOR='nvim'
export KEYTIMEOUT=1

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=${XDG_CONFIG_HOME:-$HOME/.config}/zsh/history

autoload -U colors && colors

setopt autocd

# Disable `XOFF`, so <C-s> doesn't freeze terminal
stty -ixon

# vi mode
bindkey -v

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^K" kill-line
bindkey "^D" delete-char
bindkey -s '^F' 'cd "$(dirname "$(fzf)")"\n'
bindkey -s '^O' 'lfcd\n'
bindkey "^P" clear-screen
bindkey -v '^?' backward-delete-char # Fix vi emulation backspace issues
bindkey '^[[Z' reverse-menu-complete

# Change cursor shape for different vi modes.
function zle-keymap-select() {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Wrap lf
function lfcd() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Unique pwd
function upwd() {
  [ "$PWD" = "$HOME" ] && printf "~" && return
  [ "$PWD" = "/" ] && printf "/" && return

  paths=(${(s:/:)PWD})
  cur_path='/'
  cur_short_path='/'

  for directory in ${paths[@]::-1}
  do
    cur_dir=''
    for (( j=0; j<${#directory}; j++ )); do
      cur_dir+="${directory:$j:1}"
      matching=("$cur_path"/"$cur_dir"*/)
      if [[ ${#matching[@]} -eq 1 ]]; then
        break
      fi
    done
    cur_short_path+="$cur_dir/"
    cur_path+="$directory/"
    [ "$cur_path" = "$HOME/" ] && cur_short_path="~/"
  done

  printf "${cur_short_path::-1}/${paths[-1]}"
  echo
}

function build_prompt {
  # %{\e[38;5;197m%}
  PS1="%B%F{214}[%F{1}%n%F{214}@%M "
  PS1+=$(upwd)
  PS1+="]%{$reset_color%}$%b %{$reset_color%}"
}

precmd() { build_prompt; }

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/shortcutrc"

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
