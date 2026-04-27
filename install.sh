#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/.stoic-cli"
FUNCTIONS_FILE="$INSTALL_DIR/functions.sh"
UNINSTALL_FILE="$INSTALL_DIR/uninstall.sh"
UPDATE_FILE="$INSTALL_DIR/update.sh"

SHELL_NAME="$(basename "${SHELL:-bash}")"
SOURCE_LINE="source \"$HOME/.stoic-cli/functions.sh\" # sourcing stoic-cli"

case "$SHELL_NAME" in
  bash) RC_FILE="$HOME/.bashrc" ;;
  zsh)  RC_FILE="$HOME/.zshrc" ;;
  *)
    echo "Currently, this tool only supports bash or zsh shell."
    echo "[!] Unsupported shell: $SHELL_NAME"
    exit 1
    ;;
esac

if [ -d "$INSTALL_DIR" ]; then
  echo "Updating stoic-cli..."
else
  echo "Installing stoic-cli..."
fi

if [ -f "$RC_FILE" ]; then
  TMP_FILE="$(mktemp)"
  grep -Fv "$SOURCE_LINE" "$RC_FILE" > "$TMP_FILE" || true
  mv "$TMP_FILE" "$RC_FILE"
fi

mkdir -p "$INSTALL_DIR"


SHELL_SPECIFIC_DIR="$REPO_DIR/src/$SHELL_NAME"
COMMANDS_DIR="$REPO_DIR/src/commands"
HELPERS_DIR="$REPO_DIR/src/helpers"

[ -d "$SHELL_SPECIFIC_DIR" ] || exit 1
[ -d "$COMMANDS_DIR" ] || exit 1

TMP_FILE="$(mktemp)"
{

  printf "# stoic-cli installed on $(date)"

  echo
  echo "# Helpers"
  for file in "$HELPERS_DIR"/*.sh; do
      [ -f "$file" ] || continue
      cat "$file"
      echo
  done

  echo
  echo "# $SHELL_NAME specific code"
  for file in "$SHELL_SPECIFIC_DIR"/*."$SHELL_NAME"; do
      [ -f "$file" ] || continue
      cat "$file"
      echo
  done

  echo
  echo "# Commands"
  for file in "$COMMANDS_DIR"/*.sh; do
    [ -f "$file" ] || continue
    cat "$file"
    echo
  done

} > "$TMP_FILE"

mv "$TMP_FILE" "$FUNCTIONS_FILE"


cp "$REPO_DIR/uninstall.sh" "$UNINSTALL_FILE"
chmod +x "$UNINSTALL_FILE"

cp "$REPO_DIR/update.sh" "$UPDATE_FILE"
chmod +x "$UPDATE_FILE"

cp "$REPO_DIR/version.txt" "$INSTALL_DIR/version.txt"
{
  echo " installed for $SHELL_NAME, reinstall if shell changed."
} >> "$INSTALL_DIR/version.txt"

cp "$REPO_DIR/help.txt" "$INSTALL_DIR/help.txt"
{
  echo
  echo
  cat "$INSTALL_DIR/version.txt"
} >> "$INSTALL_DIR/help.txt"


touch "$RC_FILE"

if ! grep -Fq "$SOURCE_LINE" "$RC_FILE"; then
  {
    echo "$SOURCE_LINE" # sourcing stoic-cli
  } >> "$RC_FILE"
fi

echo "stoic-cli installed successfully."
echo "Run 'stoic uninstall' to remove, after restarting the terminal."
echo "Restart terminal or run this now:"
echo "source \"$RC_FILE\""
