#!/usr/bin/env bash
set -euo pipefail

TMP_DIR="$(mktemp -d)"
REPO_URL="https://github.com/whostoic/stoic-cli.git"

cleanup() {
  rm -rf "$TMP_DIR"
}

trap cleanup EXIT

echo "Downloading latest version from '$REPO_URL'"

git clone --depth=1 "$REPO_URL" "$TMP_DIR"

cd "$TMP_DIR"

chmod +x install.sh
./install.sh