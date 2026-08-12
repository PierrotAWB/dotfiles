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
if [[ -o interactive ]]; then
    stty -ixon
    echo -ne '\e[5 q' # Use beam shape cursor on startup.
    preexec() {
        echo -ne '\e[5 q' # Use beam shape cursor for each new prompt.
    }
fi

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
  PS1="%B%F{214}[%F{1}%n%F{214}@%M "
  PS1+=$(upwd)
  PS1+="]%F{251}$%b %F{251}"
}

precmd() { build_prompt; }

function uvv {
  uv venv || return 1
  source .venv/bin/activate || return 1
  if [ -f requirements.txt ]; then
    uv pip install -r requirements.txt
  else
    echo "No requirements.txt found."
  fi
}

gcml() {
  emulate -L zsh

  local branch_name
  branch_name="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || {
    echo "Error: Not a git repository (or git is unavailable)."
    return 1
  }

  if [[ -z "${*}" ]]; then
    echo "Usage: gcml \"commit message\""
    return 1
  fi

  # Expected branch format: <name>/<ticket_project>-<ticket_number>-<description>
  # Also supports: <ticket_project>-<ticket_number>-<description> (no prefix)
  if [[ "${branch_name}" =~ '^([[:alnum:]_.-]+/)?([[:alpha:]]+)-([0-9]+)-.*' ]]; then
    local ticket_project_upper ticket_number commit_message
    ticket_project_upper="${(U)match[2]}"
    ticket_number="${match[3]}"
    commit_message="${ticket_project_upper}-${ticket_number}: ${*}"
    git commit -m "${commit_message}"
  else
    echo "Error: Invalid branch name format."
    echo "Expected: <name>/<ticket_project>-<ticket_number>-<description>"
    echo "      or: <ticket_project>-<ticket_number>-<description>"
    return 1
  fi
}

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/shortcutrc"

# Load syntax highlighting; should be last.
source "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins/F-Sy-H/F-Sy-H.plugin.zsh" 2>/dev/null

# Widgets
for f in "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/widgets/"*.zsh(N); do
    source "$f"
done

#NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Replo
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# clean-worktree drops /tmp/.cw-clear-$CMUX_PANEL_ID before ending Claude; when
# the login shell regains control, this clears the pane once on the next prompt.
_clean_worktree_clear_precmd() {
  local id="${CMUX_PANEL_ID:-$CMUX_SURFACE_ID}"
  [[ -n "$id" && -f "/tmp/.cw-clear-$id" ]] || return
  command rm -f "/tmp/.cw-clear-$id"
  clear
}
typeset -ga precmd_functions
(( ${precmd_functions[(I)_clean_worktree_clear_precmd]} )) \
  || precmd_functions+=(_clean_worktree_clear_precmd)
