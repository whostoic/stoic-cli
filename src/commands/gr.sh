gr() {

  if [ "$#" -gt 1 ]; then
    echo "gr: accepts upto one argument"
    return 1
  fi

  local dir="$1";

  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null)

  if [ -z "$root" ]; then
    echo "gr: not inside a Git repository"
    return 1
  fi

  if [ -z "$dir" ]; then
    cd "$root" || return
    return
  fi

  if [ -d "$root/$dir" ]; then
    cd "$root/$dir" || return
    return
  fi

  local matches
  matches=$(cd "$root" && git ls-files -z -co --exclude-standard | xargs -0 -I{} dirname "{}" | sort -u | grep -i "$dir" || true )

  local count
  count=$(echo "$matches" | grep -c .)

  if [ "$count" -eq 0 ]; then
    echo "gr: no match found for '$dir'"
    return 1
  elif [ "$count" -eq 1 ]; then
    cd "$root/$matches" || return
  else
    if command -v fzf >/dev/null 2>&1; then
      local selected
      selected=$(echo "$matches" | fzf --prompt="gr > ")
      [ -n "$selected" ] && cd "$root/$selected"
    else
      echo "Multiple matches found:"
      echo "$matches"
      echo "[i] Install fzf for interactive selection"
    fi
  fi
}