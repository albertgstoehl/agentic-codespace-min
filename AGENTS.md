# Tools the agent may use

- **git**: inspect diffs/branches/commit.
- **grep, sed, awk, jq**: parse files.
- **node/npm** and **python/pip**: allowed for local tooling inside the repo.
- **make**: run defined targets (e.g., `make smoke`).

Examples:
- Show uncommitted changes: `git status && git diff --stat`
- Find TODOs: `grep -RIn "TODO" || true`