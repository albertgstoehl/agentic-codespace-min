# Agent Tooling Guide

## Overview

This guide documents agentic coding workflows with Claude Code. The core philosophy centers on **Research → Plan → Implement** workflows, parallel subagent execution, and treating context as a finite resource.

**Key Principles**:
- Research before planning - understand the codebase first
- Plan before coding - create structured, phase-by-phase implementations
- Verify continuously - test after each phase
- Use specialized subagents - delegate focused tasks to keep context clean
- Leverage checkpointing - experiment with confidence using `/rewind`

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

### What Are Subagents?
Subagents are specialized agents that handle focused tasks independently. They enable parallel development workflows and keep the main context clean through just-in-time context retrieval.

Launch multiple subagents in parallel using multiple Task tool calls in a single message for maximum efficiency.

### Available Specialized Agents
When researching, Claude can spawn these specialized agents:
- **codebase-locator** - Find relevant files and their locations
- **codebase-analyzer** - Understand how implementations work
- **codebase-pattern-finder** - Identify conventions and patterns
- **test-pattern-finder** - Find testing patterns and approaches

### Subagent Design Principles
- **Single responsibility**: Each agent has one focused purpose
- **Independent execution**: Agents work in parallel without dependencies
- **Context isolation**: Agents fetch only what they need (just-in-time retrieval)
- **Results synthesis**: Main agent combines findings from subagents

### Example: Parallel Subagent Execution
```
# Launch multiple research tasks simultaneously
Task("Find authentication files", """
Use codebase-locator to find all auth-related files.
Return paths and brief descriptions.
""")

Task("Analyze auth flow", """
Use codebase-analyzer to understand authentication data flow.
Document key functions and their interactions.
""")

Task("Find auth patterns", """
Use codebase-pattern-finder to identify authentication conventions.
What patterns does this codebase follow?
""")
```

The main agent then synthesizes these findings into a coherent research document.

## Artifacts

All agent work is saved in `thoughts/`:
- `thoughts/research/` - Research documents
- `thoughts/plans/` - Implementation plans
- `thoughts/shared/` - Shared notes

## Core Workflow Patterns

### 1. Explore-Plan-Implement (Research → Plan → Code)
This pattern significantly improves outcomes for complex problems.

**Research Phase**:
1. Read relevant files without writing code
2. Spawn parallel subagents to explore different aspects
3. Use "ultrathink" for complex problems requiring deep analysis
4. Document findings in `thoughts/research/[date]-[topic].md`

**Planning Phase**:
1. Review research findings
2. Think through approach and edge cases
3. Break work into 3-7 clear phases
4. Include verification steps and rollback procedures
5. Document plan in `thoughts/plans/[date]-[topic].md`

**Implementation Phase**:
1. Execute plan phase-by-phase
2. Verify after each phase
3. Get user approval before proceeding
4. Use checkpointing (`/rewind`) for safe experimentation

### 2. Test-Driven Development (TDD)
Powerful pattern for verifiable features, especially when combined with subagents.

**Workflow**:
1. **Phase 1**: Write tests first (confirm they fail)
2. **Phase 2+**: Implement functionality to pass tests
3. **Verification**: Use subagents to verify implementation isn't overfitting

**Important**: Be explicit about doing TDD so Claude avoids creating mock implementations for non-existent functionality.

### 3. Visual Iteration
For UI/visual work:
1. Provide visual mocks or screenshots
2. Have Claude implement and screenshot results
3. Iterate 2-3 times for improved output

## Advanced Features

### Checkpointing (Safe Experimentation)
- **Auto-save**: Code state saved automatically before changes
- **Instant rewind**: Tap `Esc` twice or use `/rewind` command
- **Ambitious tasks**: Pursue wide-scale refactors with confidence
- **Works with git**: Complements version control for finer-grained control

### Background Tasks
- **Long-running processes**: Keep tasks active without blocking progress
- **Parallel work**: Continue coding while tests/builds run
- **Monitor output**: Check results when ready

### Hooks (Event-Driven Automation)
- **Automated testing**: Run test suites after code changes
- **Code quality**: Perform linting before commits
- **Custom workflows**: Trigger any action on specific events

## Context Engineering Best Practices

### Treat Context as Finite Resource
- **Minimal high-signal information**: Provide smallest set that fully outlines expected behavior
- **Attention budget**: Every token competes for the model's limited attention
- **Diminishing returns**: More context isn't always better

### Effective Context Management
- **Just-in-time retrieval**: Load context when needed, not upfront
- **Structured artifacts**: Store research/plans in `thoughts/` to maintain memory outside context window
- **Subagent architectures**: Delegate complex tasks to keep main context clean
- **Compaction**: Summarize conversation history when context grows large

### CLAUDE.md Optimization
The `.claude/CLAUDE.md` file is automatically loaded into context. Use it for:
- Repository conventions (branch naming, merge vs. rebase)
- Testing approaches and verification commands
- Available slash commands and specialized agents
- Project-specific patterns to follow

**Important**: Keep CLAUDE.md focused - quality over quantity.

## Tips

### Workflow Best Practices
- **Research before planning** - understand the codebase first (significantly improves outcomes)
- **Keep plans focused** - 3-7 phases is ideal for clarity
- **Verify after each phase** - don't skip verification steps
- **Update plans as you go** - they're living documents
- **Use parallel subagents** - launch multiple research tasks simultaneously
- **Leverage checkpointing** - experiment boldly with `/rewind` as safety net

### Context Optimization
- **Clear instructions at right altitude** - match abstraction level to task
- **Organized prompts** - use sections like `<background>`, `<instructions>`
- **Self-contained tools** - make tools robust to error and extremely clear
- **Avoid bloat** - no overlapping functionality in tool sets

### Verification Strategy
- **Course-correct early** - catch issues before they accumulate
- **Use checklists** - break complex verification into steps
- **Independent review** - use subagents or human review to verify work
- **Automated tests as safety net** - TDD catches regressions automatically

## Learning Resources

For comprehensive best practices research, see:
- `thoughts/research/2025-10-06-anthropic-agentic-coding-best-practices.md`

Official Anthropic sources:
- Claude Code Best Practices (Anthropic Engineering Blog)
- Effective Context Engineering for AI Agents
- Writing Effective Tools for AI Agents
- Enabling Claude Code to Work More Autonomously
