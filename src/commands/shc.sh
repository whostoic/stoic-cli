shc() {

  if [ "$#" -eq 0 ]; then
    echo "shc: missing shortcut name"
    return 1
  fi

  if [ "$#" -gt 1 ]; then
    echo "shc: accepts exactly one argument"
    return 1
  fi

  local key="$1"
  local root
  local shortcuts_file
  local line
  local rel_path


  root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "shc:  not inside a Git repository"
    return 1
  }

  shortcuts_file="$root/.stoic-shortcuts"


  if [ ! -f "$shortcuts_file" ]; then
    echo "shc: .stoic-shortcuts not found in repo root"
    return 1
  fi


  line="$(grep -E "^${key}=" "$shortcuts_file" | head -n 1)"

  if [ -z "$line" ]; then
    echo "shc: shortcut '$key' not found"
    return 1
  fi

  rel_path="${line#*=}"

  if [ -z "$rel_path" ]; then
    echo "shc: shortcut '$key' has empty path"
    return 1
  fi


  if [ ! -d "$root/$rel_path" ]; then
    echo "shc: target directory does not exist: $rel_path"
    return 1
  fi

  cd "$root/$rel_path" || return 1
}