SHELL := /usr/bin/env bash
.PHONY: smoke agent loop sandbox

smoke: ; bash scripts/smoke.sh
agent: ; bash scripts/agent.sh
loop:  ; bash scripts/loop.sh
sandbox: ; bash scripts/sandbox.sh