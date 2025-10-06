#!/usr/bin/env bash
set -euo pipefail
BRANCH="${AGENT_BRANCH:-agent-run}"
LOG_DIR="${AGENT_LOG_DIR:-.agent-logs}"
mkdir -p "$LOG_DIR"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "Not a git repo"; exit 1; }
git fetch --all --quiet || true
if ! git show-ref --verify --quiet "refs/heads/$BRANCH"; then
  git checkout -b "$BRANCH"
else
  git checkout "$BRANCH"
fi
echo "[sandbox] on branch $BRANCH; logs in $LOG_DIR"