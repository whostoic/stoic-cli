mkfile() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: mkfile <path> [-c <content>] ..." >&2
        return 1
    fi

    while [[ $# -gt 0 ]]; do
        local path="$1"
        shift

        local content=""

        if [[ "$1" == "-c" ]]; then
            if [[ -z "$2" ]]; then
                echo "Error: -c requires content" >&2
                return 1
            fi

            content="$2"
            shift 2
        fi

        mkdir -p -- "$(dirname -- "$path")" || return 1
        printf '%s' "$content" > "$path" || return 1
    done
}