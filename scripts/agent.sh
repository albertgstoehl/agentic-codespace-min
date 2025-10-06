#!/usr/bin/env bash
set -euo pipefail

GOAL="${1:-"improve repo DX (no-op)"}"
LOG_DIR="${AGENT_LOG_DIR:-.agent-logs}"
mkdir -p "$LOG_DIR"

# 1) Ask Claude to output a SINGLE safe shell command (no heredocs).
CMD_JSON="$(claude ask "Goal: $GOAL
Output ONLY valid JSON: {\"cmd\":\"<one shell command>\"}.
Constraints:
- Prefer read/inspect first; write only if needed.
- No destructive ops (no rm -rf /, no sudo, no networking beyond git/npm/pip unless I've added examples in AGENTS.md).
- Keep commands idempotent where possible.
- Work inside the repo.
- If install needed, explain via echo && exit 0." )" || true

# 2) Extract command (fallback to 'echo noop').
CMD="$(printf '%s' "$CMD_JSON" | sed -n 's/.*\"cmd\"[[:space:]]*:[[:space:]]*\"\\(.*\\)\".*/\\1/p' | head -n1)"
[ -z "${CMD:-}" ] && CMD="echo noop"

# 3) Very light guardrails (block obvious footguns).
if grep -Eqi '(^|[[:space:]])(sudo|rm -rf[[:space:]]+/|mkfs|:(){:|:&};:)' <<<"$CMD"; then
  echo "[agent] blocked dangerous command: $CMD" | tee -a "$LOG_DIR/blocked.log"
  exit 0
fi

# 4) Run and log.
TS="$(date -u +%Y%m%dT%H%M%SZ)"
echo "\$ $CMD" | tee -a "$LOG_DIR/run-$TS.log"
set +e
bash -lc "$CMD" >>"$LOG_DIR/run-$TS.log" 2>&1
RC=$?
set -e
echo "[agent] exit=$RC; log=$LOG_DIR/run-$TS.log"

# 5) If repo changed, commit a checkpoint.
if ! git diff --quiet || ! git diff --staged --quiet; then
  git add -A
  git commit -m "agent: step at $TS" >/dev/null 2>&1 || true
fi
exit 0