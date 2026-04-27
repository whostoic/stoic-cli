_gr_complete() {
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null)
  [[ -z "$root" ]] && return

  local dirs
  dirs=(${(f)$(cd "$root" && git ls-files -co --exclude-standard | xargs -I{} dirname "{}" | sort -u)})
  _describe 'directories' dirs
}

compdef _gr_complete gr