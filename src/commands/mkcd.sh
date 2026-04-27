mkcd() {
  if [ "$#" -eq 0 ]; then
    echo "mkcd: missing directory name"
    return 1
  fi

  if [ "$#" -gt 1 ]; then
    echo "mkcd: accepts exactly one argument"
    return 1
  fi

  local dir="$1"

  mkdir -p "$dir" && cd "$dir"
}