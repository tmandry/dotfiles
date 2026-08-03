# jj + git-worktree bridge.
#
# jj's colocated mode only tracks ONE working copy (the repo's main git
# directory). Linked `git worktree` checkouts (created by Claude Code, Zed,
# Codex, or `git worktree add` by hand) have no .jj of their own, and jj
# workspaces can't be retrofitted onto them (jj refuses non-empty
# destinations, and a jj workspace has no .git anyway, which breaks tools
# that expect one). So: run from inside a linked worktree, commit whatever's
# on disk, hop to the main git dir, and run jj there against the branch.
#
#   jjw absorb -f mybranch
#   jjw log -r mybranch
#
# Rewriting a branch's commit from jj (describe/absorb/rebase/etc.) detaches
# HEAD in *any other worktree* that has that branch checked out as a side
# effect of exporting the moved ref back to git - it does not touch that
# worktree's files, it just stops tracking the branch there, so a later plain
# `git commit` in that worktree would silently stop advancing the branch.
# Only run jjw against a branch nobody else is actively committing to right
# now. After a jj command rewrites the branch, pull the result back onto disk
# and reattach:
#
#   jjw-sync
_jjw_main_root() {
  git rev-parse --path-format=absolute --git-common-dir 2>/dev/null | sed 's#/\.git$##'
}

# Detached HEAD makes `git rev-parse --abbrev-ref HEAD` return the literal
# string "HEAD", which would silently turn a naive `git reset --hard
# "$branch"` into a no-op reset-to-self. Require an actual branch.
_jjw_branch() {
  git symbolic-ref --quiet --short HEAD
}

# Per-worktree (not shared) state dir, so jjw-sync can recover the branch
# name after jj has detached HEAD out from under this worktree.
_jjw_state_file() {
  local gitdir
  gitdir="$(git rev-parse --git-dir 2>/dev/null)" || return 1
  echo "$gitdir/JJW_BRANCH"
}

# jjw's own auto-commits are tagged with this prefix as their description.
_jjw_wip_prefix="wip: jjw sync ("

# If a jj command (any of them - absorb, rebase, whatever) fully consumed a
# jjw auto-commit's content, its bookmark is left pointing at an empty shell
# instead of being auto-abandoned, because it still has a description (jj
# only auto-abandons a source commit that has none). `jj abandon` on a commit
# a bookmark points to *deletes* the bookmark rather than sliding it down to
# the parent - that only happens for descendants via rebase, and an emptied
# tip commit has none. So: move the bookmark down first, then abandon the
# now-bookmark-free shell. Only touches commits carrying jjw's own WIP
# marker, so it never eats a real empty commit (e.g. an empty merge) that
# happens to land at a branch tip. Loops in case more than one stacks up.
_jjw_collapse_empty_wip() {
  local main_root="$1" branch="$2" desc empty
  while true; do
    desc="$(jj -R "$main_root" log --no-graph -r "$branch" -T 'description' 2>/dev/null)" || return 0
    [[ "$desc" == "${_jjw_wip_prefix}"* ]] || return 0
    empty="$(jj -R "$main_root" log --no-graph -r "$branch" -T 'if(empty, "1", "0")' 2>/dev/null)"
    [[ "$empty" == "1" ]] || return 0
    jj -R "$main_root" bookmark set "$branch" -r "${branch}-" --allow-backwards --quiet
    jj -R "$main_root" abandon -r "${branch}+" --quiet
    echo "jjw: collapsed empty WIP commit left on $branch" >&2
  done
}

jjw() {
  local main_root branch state_file
  main_root="$(_jjw_main_root)" || { echo "jjw: not in a git repo" >&2; return 1; }
  branch="$(_jjw_branch)" || { echo "jjw: HEAD is detached, not on a branch" >&2; return 1; }
  state_file="$(_jjw_state_file)" || return 1
  echo "$branch" > "$state_file"
  if [[ -n "$(git status --porcelain)" ]]; then
    git add -A && git commit -m "${_jjw_wip_prefix}$branch)" --quiet
    echo "jjw: committed local changes on $branch"
  fi
  (cd "$main_root" && jj git import --quiet && jj "$@")
  _jjw_collapse_empty_wip "$main_root" "$branch"
  if ! git symbolic-ref --quiet HEAD >/dev/null 2>&1; then
    echo "jjw: jj detached this worktree from $branch while updating it; run 'jjw-sync' to reattach and pick up the result" >&2
  fi
}

jjw-sync() {
  local main_root state_file branch
  main_root="$(_jjw_main_root)" || { echo "jjw-sync: not in a git repo" >&2; return 1; }
  state_file="$(_jjw_state_file)" || return 1
  if branch="$(_jjw_branch)"; then
    : # already attached, e.g. no rewrite happened
  elif [[ -f "$state_file" ]]; then
    branch="$(<"$state_file")"
  else
    echo "jjw-sync: HEAD is detached and no jjw state found; reattach manually with 'git checkout <branch>'" >&2
    return 1
  fi
  _jjw_collapse_empty_wip "$main_root" "$branch"
  git checkout "$branch" && rm -f "$state_file"
}
