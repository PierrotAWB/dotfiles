fzf-git-branch-widget() {
  emulate -L zsh
  setopt localoptions pipefail no_aliases

  local selected
  selected="$(
    git reflog show --format='%gs' 2>/dev/null \
      | sed -n 's/^checkout: moving from .* to //p' \
      | awk 'NF && !seen[$0]++' \
      | fzf-tmux -p 90%,80% \
          --prompt='branch> ' \
          --no-multi \
          --preview-window='right,30%,wrap' \
          --preview='git log --oneline --decorate -40 --color=always {}'
  )"

  local ret=$?
  if [[ $ret -eq 0 && -n "$selected" ]]; then
    if ! git switch -- "$selected"; then
      zle -M "git switch failed (likely due to local changes)"
    fi
  fi

  zle reset-prompt
  return $ret
}
zle -N fzf-git-branch-widget

bindkey '^b' fzf-git-branch-widget
