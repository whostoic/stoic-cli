mkfile() {
    if [[ -z "$1" ]]; then
        echo "Error: file path is required" >&2
        return 1
    fi

    local path="$1"
    local content="${2:-}"

    mkdir -p "$(dirname -- "$path")" || return 1
    printf '%s' "$content" > "$path"
}
