# Setup fzf
# ---------
if [[ ! "$PATH" == */home/andrew/.config/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/andrew/.config/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/andrew/.config/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/andrew/.config/fzf/shell/key-bindings.zsh"
