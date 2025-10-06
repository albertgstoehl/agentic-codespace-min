# Repository Context for Claude Code

## What This Is
Minimal sandbox for manual AI-assisted development using research → plan → implement workflow.

## Available Commands
- `/project:research_codebase` - Research codebase to understand context
- `/project:create_plan` - Create phase-by-phase implementation plan
- `/project:implement_plan <file>` - Execute a plan step-by-step

## Specialized Subagents
When researching, you have access to these specialized agents:
- `codebase-locator` - Find relevant files and their locations
- `codebase-analyzer` - Understand how implementations work
- `codebase-pattern-finder` - Identify conventions and patterns
- `test-pattern-finder` - Find testing patterns and approaches

## Verification Commands
```bash
# Add your project-specific commands here
npm test              # Run tests
npm run typecheck     # Type checking
npm run lint          # Linting
npm run build         # Build project
```

## Workflow Guidelines

### Research Phase
- Focus on understanding existing patterns
- Document what exists, not what should exist
- Output to: `thoughts/research/[date]-[topic].md`

### Planning Phase
- Break work into 3-7 clear phases
- Each phase has specific files and verification steps
- Output to: `thoughts/plans/[date]-[topic].md`

### Implementation Phase
- Follow the plan phase-by-phase
- Verify after each phase
- You drive the process - approve/reject each step

## Artifacts Location
- Research: `thoughts/research/`
- Plans: `thoughts/plans/`
- Shared notes: `thoughts/shared/`

## Code Style
- Follow existing patterns in the codebase
- Use clear, descriptive names
- Add comments only for complex logic
- Match the formatting of surrounding code
