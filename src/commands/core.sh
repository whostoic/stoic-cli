stoic() {
  case "${1:-}" in
    version)
      stoic_cli_helper__print_version
      ;;
    uninstall)
      stoic_cli_helper__uninstall_cli
      ;;
    update)
      stoic_cli_helper__update_cli
      ;;
    *)
      cat "$HOME/.stoic-cli/help.txt"
      ;;
  esac
}