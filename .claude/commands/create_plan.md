# Create Implementation Plan Command

You are tasked with creating a detailed, phase-by-phase implementation plan based on research findings or your understanding of the task.

## Initial Response

**Tip:** You can invoke this command with a specific focus:
- `/create_plan` - For a general planning session
- `/create_plan [description]` - For a specific task
- `/create_plan thoughts/research/[file].md` - Based on specific research

Then wait for the user's input or read the specified file.

## Planning Process

### Step 1: Gather Context (Before Planning)

If research exists, read it completely:
- Read any relevant research documents from `thoughts/research/`
- Understand the patterns and conventions discovered
- Note any constraints or architectural decisions

If no research exists, spawn research tasks:
- Use the `codebase-locator` agent to find related files
- Use the `codebase-analyzer` agent to understand current implementation
- Use the `codebase-pattern-finder` agent to identify conventions to follow

### Step 2: Think Through the Approach

Use extended thinking for complex tasks:
- For simple tasks: proceed directly
- For medium complexity: "think hard about the implementation approach"
- For complex tasks: "ultrathink about the implementation strategy, edge cases, and testing"

### Step 3: Decompose into Phases

Break the work into 3-7 clear phases:
- Each phase should accomplish ONE clear objective
- Each phase should take < 5-10 minutes to implement
- Each phase must have specific verification steps
- Each phase must have rollback instructions

### Step 4: Generate Implementation Plan

Write the plan to `thoughts/plans/[date]-[topic].md`:

```markdown
---
date: [Current date and time with timezone]
researcher: Claude
git_commit: [Current commit hash]
branch: [Current branch name]
topic: "[Task Description]"
research_file: "[Path to research if used]"
estimated_phases: [number]
status: ready_for_implementation
---

# Implementation Plan: [Task Name]

**Date**: [Current date and time]
**Git Commit**: [Current commit hash]
**Branch**: [Current branch]
**Research**: [Link to research doc if applicable]

## Overview
[Brief description of what we're implementing and why]

## Current State Analysis
[What exists now, what's missing, key constraints discovered]

## Desired End State
[Clear specification of what success looks like]

### Key Discoveries:
- [Important finding with file:line reference]
- [Pattern to follow from codebase]
- [Constraint to work within]

## What We're NOT Doing
[Explicitly list out-of-scope items to prevent scope creep]

## Implementation Approach
[High-level strategy and reasoning]

---

## Phase 1: [Descriptive Name]

### Overview
[What this phase accomplishes]

### Changes Required:

#### 1. [Component/File Group]
**File**: `path/to/file.ext`

**Changes**:
```[language]
// Specific code to add/modify
// Use actual code examples where helpful
```

**Reasoning**: [Why this approach, based on research or codebase patterns]

### Success Criteria:

#### Automated Verification:
- [ ] Tests pass: `npm test -- path/to/relevant.test.ts`
- [ ] Type checking: `npm run typecheck`
- [ ] Linting: `npm run lint`

#### Manual Verification:
- [ ] [Specific behavior to check]
- [ ] [Expected output or UI state]

### Rollback Plan:
```bash
git restore path/to/file.ext
# Verify rollback: npm test
```

**Status**: [ ] Not Started

---

## Phase 2: [Next Phase Name]

### Overview
[What this phase accomplishes]

### Prerequisites
- [ ] Phase 1 complete and verified

### Changes Required:
[Similar structure to Phase 1]

**Status**: [ ] Not Started

---

[Continue for each phase...]

---

## Final Verification

After all phases complete:
```bash
# Complete test suite
npm test

# Type checking
npm run typecheck

# Linting
npm run lint

# Build verification
npm run build

# Manual checks:
# 1. [Specific thing to verify]
# 2. [Another verification step]
```

## Rollback Strategy

If implementation fails at any phase:
```bash
# Restore all modified files
git restore [list all files]

# Verify system is stable
npm test
npm run build
```

## Notes for Implementation
- [Any important reminders]
- [Gotchas to watch for]
- [References to relevant documentation]
```

## Important Guidelines

- **Be specific**: Include actual file paths, line numbers when relevant
- **Verify everything**: Each phase needs concrete verification steps
- **Think about rollback**: Every phase needs a clear undo path
- **Keep phases small**: 3-7 phases optimal, each < 10 minutes
- **Reference research**: Use patterns discovered in research phase
- **Document reasoning**: Explain why this approach, not just what to do

## Examples of Good Phases

**Good Phase:**
```markdown
## Phase 1: Add User Model Type Definition

### Changes Required:
**File**: `src/types/User.ts`
```typescript
export interface User {
  id: string;
  email: string;
  createdAt: Date;
}
```

### Verification:
- [ ] `npm run typecheck` passes
- [ ] Can import type in other files without errors
```

**Bad Phase (too vague):**
```markdown
## Phase 1: Setup types
Add necessary types for users
```

The good phase is specific, verifiable, and clear.
