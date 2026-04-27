_gr_complete() {
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null)
  [ -z "$root" ] && return

  local cur="${COMP_WORDS[COMP_CWORD]}"
  local dirs
  dirs=$(cd "$root" && git ls-files -co --exclude-standard | xargs -I{} dirname "{}" | sort -u)
  COMPREPLY=($(compgen -W "$dirs" -- "$cur"))
}

complete -F _gr_complete gr