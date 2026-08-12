_fzf-git-worktree-preview() {
  local branch kind local_branch
  branch="$1"
  kind="$2"
  if [ "$kind" = "remote" ]; then
    local_branch="${branch#*/}"
    echo "Remote: $branch"
    echo "Local candidate: $local_branch"
    echo
    git log --oneline --decorate -40 --color=always "$branch"
  else
    echo "Local: $branch"
    echo
    git log --oneline --decorate -40 --color=always "$branch"
  fi
}

fzf-git-worktree-widget() {
  emulate -L zsh
  setopt localoptions pipefail no_aliases

  # Must be in a git repo
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1

  # Where to create worktrees: sibling dir of the current repo root
  local repo_root parent_root
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || return 1
  parent_root="$(cd "$repo_root/.." && pwd -P)" || return 1

  # Build a candidate list: locals + remotes, prettified
  # We'll present "name<TAB>kind<TAB>ref" so we can parse cleanly.
  local fmt_local fmt_remote
  fmt_local=$'%(refname:short)\tlocal\t%(refname)'
  fmt_remote=$'%(refname:short)\tremote\t%(refname)'

  local selected line name kind ref
  selected=$(
    {
      git for-each-ref --format="$fmt_local" refs/heads 2>/dev/null
      git for-each-ref --format="$fmt_remote" refs/remotes 2>/dev/null | awk -F'\t' '$1 !~ /\/HEAD$/'
    } | fzf-tmux -p 90%,80% \
        --prompt='worktree> ' \
        --no-multi \
        --with-nth=1,2 \
        --delimiter=$'\t' \
        --preview-window='right,40%,wrap' \
        --preview='_fzf-git-worktree-preview "$(echo {} | cut -f1)" "$(echo {} | cut -f2)"'
  )

  local ret=$?
  if [[ $ret -ne 0 || -z "$selected" ]]; then
    zle reset-prompt
    return $ret
  fi

  # Parse selection
  IFS=$'\t' read -r name kind ref <<<"$selected"

  # Decide local branch name + worktree dir
  local branch local_branch wt_dir wt_path
  branch="$name"
  if [[ "$kind" == "remote" ]]; then
    # origin/feature/foo -> feature/foo
    local_branch="${branch#*/}"
  else
    local_branch="$branch"
  fi

  wt_dir="$local_branch"
  wt_path="$parent_root/$wt_dir"

  # If path exists, just offer to cd into it
  if [[ -e "$wt_path" ]]; then
    zle -M "Path exists: $wt_path (cd?) [y/N]"
    local ans
    read -r ans
    if [[ "$ans" == [yY]* ]]; then
      builtin cd -- "$wt_path" || {
        zle -M "cd failed: $wt_path"
        zle reset-prompt
        return 1
      }
    else
      zle -M "Aborted (path already exists)."
    fi
    zle reset-prompt
    return 0
  fi

  # If worktree already exists for this branch, jump to it (common case)
  local existing_path
  existing_path="$(
    git worktree list --porcelain 2>/dev/null \
      | awk -v b="$local_branch" '
          $1=="worktree" {path=$2}
          $1=="branch" && $2 ~ ("refs/heads/" b "$") { print path; exit }
        '
  )"
  if [[ -n "$existing_path" ]]; then
    zle -M "Worktree already exists for $local_branch: $existing_path (cd?) [y/N]"
    local ans2
    read -r ans2
    if [[ "$ans2" == [yY]* ]]; then
      builtin cd -- "$existing_path" || zle -M "cd failed: $existing_path"
    fi
    zle reset-prompt
    return 0
  fi

  # Determine whether local branch exists
  local has_local=0
  if git show-ref --verify --quiet "refs/heads/$local_branch"; then
    has_local=1
  fi

  # Create worktree
  # Cases:
  #  - local branch exists:  git worktree add ../branch branch
  #  - picked a remote branch: create local tracking branch: git worktree add -b branch ../branch origin/branch
  #  - picked local that doesn't exist (unlikely): create it: git worktree add -b branch ../branch
  if [[ $has_local -eq 1 ]]; then
    if ! git worktree add -- "$wt_path" "$local_branch"; then
      zle -M "git worktree add failed"
      zle reset-prompt
      return 1
    fi
  else
    if [[ "$kind" == "remote" ]]; then
      # Track the selected remote branch
      if ! git worktree add -b "$local_branch" -- "$wt_path" "$branch"; then
        zle -M "git worktree add -b failed"
        zle reset-prompt
        return 1
      fi
    else
      # Create a new local branch at current HEAD
      if ! git worktree add -b "$local_branch" -- "$wt_path"; then
        zle -M "git worktree add -b failed"
        zle reset-prompt
        return 1
      fi
    fi
  fi

  # Optionally jump into it
  zle -M "Created worktree: $wt_path (cd?) [y/N]"
  local ans3
  read -r ans3
  if [[ "$ans3" == [yY]* ]]; then
    builtin cd -- "$wt_path" || zle -M "cd failed: $wt_path"
  fi

  zle reset-prompt
  return 0
}
zle -N fzf-git-worktree-widget
bindkey '^w' fzf-git-worktree-widget

