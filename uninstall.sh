#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.stoic-cli"
SHELL_NAME="$(basename "${SHELL:-bash}")"
SOURCE_LINE="source \"$HOME/.stoic-cli/functions.sh\""

case "$SHELL_NAME" in
  bash) RC_FILE="$HOME/.bashrc" ;;
  zsh)  RC_FILE="$HOME/.zshrc" ;;
  *)
    echo "Shell may have changed."
    echo "Previous shell RC file is untouched."
    ;;
esac

echo "Removing stoic-cli..."

if [ -f "$RC_FILE" ]; then
  TMP_FILE="$(mktemp)"
  grep -Fv "$SOURCE_LINE" "$RC_FILE" > "$TMP_FILE" || true
  mv "$TMP_FILE" "$RC_FILE"
fi

rm -rf "$INSTALL_DIR"

echo "stoic-cli removed successfully."
echo "Restart terminal or run:"
echo "$RC_FILE"
