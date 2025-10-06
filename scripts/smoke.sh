#!/usr/bin/env bash
set -euo pipefail
echo "[smoke] checking CLIs..."
command -v claude >/dev/null || { echo "claude not found"; exit 1; }
command -v codex  >/dev/null || echo "codex not found (optional)"
echo "[smoke] versions:"
claude --version || true
codex --version  || true
echo "[smoke] done."