# agentic-codespace-min

Ultra-minimal Codespaces base for **self-running coding agents** with guardrails:
- Runs in a scratch branch
- Logs every command
- Timeboxed loop + step cap

## Quick start (Codespaces)

### Option A: Account-based Authentication (Recommended)
1. Create a Codespace on your **personal repo**
2. In the Codespace terminal, authenticate CLIs:
   ```bash
   claude login    # Opens browser for Anthropic account login
   codex login     # Opens browser for OpenAI account login (if using)
   ```
3. Test with: `make smoke`
4. Run agent: `make loop GOAL="upgrade DX slightly"`

### Option B: API Key Authentication
1. Add Codespaces Secrets (GitHub → Settings → Codespaces → Secrets):
   - `ANTHROPIC_API_KEY` (for direct API access)
   - `OPENAI_API_KEY` (optional)
2. Set up in terminal or use directly in scripts
3. Run: `make smoke && make loop GOAL="upgrade DX slightly"`

**YOLO mode note**: Claude Code supports skipping confirmations (dangerous). We're giving it auto-approval by design but blocking obvious footguns and isolating changes in `agent-run`. For tighter sandboxing, run in Codespaces and keep secrets minimal.

## Why this shape?

Inspired by Willison's agentic loops: run tools **in a loop** toward a clear goal; use a safe environment (Codespaces), tight credentials, and timebox. See links below.

## Links

* [Designing agentic loops (Simon Willison, Sep 30, 2025)](https://simonwillison.net/2025/Sep/30/designing-agentic-loops/)
