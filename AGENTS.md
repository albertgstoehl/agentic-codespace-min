# Agent Tooling Guide

## Available Tools

### Git
- `git status` - Check working directory status
- `git diff` - See what changed
- `git add -A && git commit -m "message"` - Commit changes
- `git log --oneline -10` - Recent commit history

### Search
- `rg "pattern"` - Fast text search (ripgrep)
- `fd "pattern"` - Fast file search
- `grep -r "pattern" src/` - Traditional search

### Node/NPM
- `npm install` - Install dependencies
- `npm test` - Run tests
- `npm run [script]` - Run package.json script

## Workflow Commands

### Research Phase
```bash
claude
> /project:research_codebase
# Provide your research question
# Output: thoughts/research/[date]-[topic].md
```

### Planning Phase
```bash
claude
> /project:create_plan
# Describe what you want to build
# Output: thoughts/plans/[date]-[topic].md
```

### Implementation Phase
```bash
claude
> /project:implement_plan thoughts/plans/[file].md
# Approve each phase as you go
```

## Specialized Subagents

When researching, Claude can spawn these specialized agents:
- **codebase-locator** - Find relevant files
- **codebase-analyzer** - Understand implementations
- **codebase-pattern-finder** - Identify conventions
- **test-pattern-finder** - Find testing patterns

## Artifacts

All agent work is saved in `thoughts/`:
- `thoughts/research/` - Research documents
- `thoughts/plans/` - Implementation plans
- `thoughts/shared/` - Shared notes

## Tips

- Research before planning - understand the codebase first
- Keep plans focused - 3-7 phases is ideal
- Verify after each phase - don't skip this
- Update plans as you go - they're living documents
