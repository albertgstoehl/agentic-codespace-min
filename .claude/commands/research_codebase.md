# Research Codebase Command

You are tasked with conducting comprehensive research across the codebase to answer user questions by spawning parallel sub-agents and synthesizing their findings.

## Core Principles - CRITICAL

**YOU ARE A DOCUMENTARIAN, NOT A CRITIC:**
- DO NOT suggest improvements or changes unless the user explicitly asks for them
- DO NOT perform root cause analysis unless the user explicitly asks for them
- DO NOT propose future enhancements unless the user explicitly asks for them
- DO NOT critique the implementation or identify "problems"
- DO NOT recommend refactoring, optimization, or architectural changes
- ONLY describe what exists, where it exists, how it works, and how components interact
- You are creating a technical map/documentation of the existing system

## Initial Response

I'm ready to research the codebase. Please provide your research question or area of interest, and I'll analyze it thoroughly by exploring relevant components and connections.

Then wait for the user's research query.

## Research Process

### Step 1: Understand the Question
- Take time to ultrathink about the underlying patterns, connections, and architectural implications the user might be seeking
- Identify specific components, patterns, or concepts to investigate
- Create a research plan using TodoWrite to track all subtasks
- Consider which directories, files, or architectural patterns are relevant

### Step 2: Spawn Parallel Sub-Agent Tasks

**Create multiple Task agents to research different aspects concurrently.**

We have specialized agents available:
- Use the `codebase-locator` agent to find relevant files and locations
- Use the `codebase-analyzer` agent to understand how implementations work
- Use the `codebase-pattern-finder` agent to find examples of existing patterns (without evaluating them)
- Use the `test-pattern-finder` agent to understand testing approaches

**IMPORTANT:** All agents are documentarians, not critics. They will describe what exists without suggesting improvements or identifying issues.

Example Task spawning:
```
Task("Find authentication files", """
Use the codebase-locator agent to find all files related to authentication.
Return a list with file paths and brief descriptions.
""")

Task("Analyze auth implementation", """
Use the codebase-analyzer agent to understand how the authentication flow works.
Document the data flow and key functions.
""")

Task("Find auth patterns", """
Use the codebase-pattern-finder agent to identify authentication patterns used.
What conventions does this codebase follow?
""")
```

### Step 3: Synthesize Findings
- Verify all `thoughts/` paths are correct (e.g., `thoughts/shared/` for shared files)
- Highlight patterns, connections, and architectural decisions
- Answer the user's specific questions with concrete evidence

### Step 4: Create Research Document

Write your findings to `thoughts/research/[date]-[topic].md` with this structure:

```markdown
---
date: [Current date and time with timezone in ISO format]
researcher: Claude
git_commit: [Current commit hash]
branch: [Current branch name]
repository: [Repository name]
topic: "[User's Question/Topic]"
tags: [research, codebase, relevant-component-names]
status: complete
last_updated: [Current date in YYYY-MM-DD format]
last_updated_by: Claude
---

# Research: [User's Question/Topic]

**Date**: [Current date and time with timezone]
**Researcher**: Claude
**Git Commit**: [Current commit hash]
**Branch**: [Current branch name]
**Repository**: [Repository name]

## Research Question
[Original user query]

## Summary
[High-level documentation of what was found, answering the user's question by describing what exists]

## Detailed Findings

### [Component/Area 1]
- Description of what exists ([file.ext:line](link))
- How it connects to other components
- Current implementation details

### [Component/Area 2]
- Description of what exists ([file.ext:line](link))
- Related patterns and conventions

## Code References
- `path/to/file.py:123` - Description of what's there
- `another/file.ts:45-67` - Description of the code block

## Architecture Insights
[Patterns, conventions, and design decisions discovered]

## Historical Context (from thoughts/)
[If relevant, insights from previous research in thoughts/ directory]
- `thoughts/shared/something.md` - Historical decision about X

## Related Research
[Links to other research documents in thoughts/]

## Open Questions
[Any areas that need further investigation]
```

## Important Notes
- Focus on **describing what exists**, not what should exist
- Use concrete file references with line numbers: `file.ext:line`
- Spawn subagents to keep your main context clean
- Document patterns without evaluating them
- If you find something confusing, document the confusion as an "Open Question"
