#!/usr/bin/env bash
set -euo pipefail

GOAL="${1:-"make small repo improvements"}"
MAX_STEPS="${AGENT_MAX_STEPS:-30}"
TIMEBOX_MIN="${AGENT_TIMEBOX_MIN:-20}"

echo "[loop] goal: $GOAL"
bash scripts/sandbox.sh

START="$(date +%s)"
for ((i=1;i<=MAX_STEPS;i++)); do
  NOW="$(date +%s)"
  ELAPSED_MIN=$(( (NOW-START)/60 ))
  if (( ELAPSED_MIN >= TIMEBOX_MIN )); then
    echo "[loop] timebox hit (${ELAPSED_MIN}min) — stopping"
    break
  fi
  echo "[loop] step $i/$MAX_STEPS"
  bash scripts/agent.sh "$GOAL"
done

echo "[loop] finished. Current branch: $(git branch --show-current)"