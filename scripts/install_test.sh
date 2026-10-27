#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for cmd in python3 pip node npm; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing required command: $cmd"
    exit 1
  fi
done

if [ ! -d "$repo_root/backend" ]; then
  echo "Missing backend directory"
  exit 1
fi

if [ ! -d "$repo_root/mobile" ]; then
  echo "Missing mobile directory"
  exit 1
fi

echo "[1/3] Checking backend Python files..."
python3 -m compileall "$repo_root/backend"

echo "[2/3] Checking mobile package manifest..."
cd "$repo_root/mobile"
npm install --silent --package-lock-only --ignore-scripts

echo "[3/3] Install validation passed."
echo "Backend and mobile project files are present and the dependency metadata resolves cleanly."
