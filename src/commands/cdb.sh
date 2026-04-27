cdb() {
  local steps=${1:-1}

  if ! [[ "$steps" =~ ^[0-9]+$ ]] || [ "$steps" -lt 1 ]; then
    echo "Usage: cdb <positive_number>"
    return 1
  fi

  local path=""
  for ((i=0; i<steps; i++)); do
    path+="../"
  done

  cd "$path" || return
}