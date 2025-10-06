---
date: 2025-10-06T00:00:00Z
researcher: Claude
git_commit: faec4019edfc66cb960e1fa67b73444fb0a95cba
branch: main
repository: agentic-codespace-min
topic: "Anthropic Best Practices for Agentic Coding with Claude Code"
tags: [research, best-practices, agentic-coding, claude-code, anthropic, 2025]
status: complete
last_updated: 2025-10-06
last_updated_by: Claude
---

# Research: Anthropic Best Practices for Agentic Coding with Claude Code

**Date**: 2025-10-06
**Researcher**: Claude
**Git Commit**: faec4019edfc66cb960e1fa67b73444fb0a95cba
**Branch**: main
**Repository**: agentic-codespace-min

## Research Question
What are the official best practices from Anthropic for agentic coding with Claude Code in 2025?

## Summary
Anthropic has established comprehensive best practices for agentic coding with Claude Code, centered around three key workflow patterns: **Explore-Plan-Implement**, **Test-Driven Development**, and **Visual Iteration**. The 2025 updates introduce powerful new features including **subagents** for parallel task execution, **checkpointing** for safe experimentation, and advanced **context engineering** techniques. The core philosophy is to treat context as a finite resource, use specialized agents for complex tasks, and leverage research-first workflows for better outcomes.

## Detailed Findings

### 1. Core Workflow Patterns

#### Explore-Plan-Implement (Research → Plan → Code)
**Source**: Anthropic Engineering Blog - Claude Code Best Practices

- **Read files first without writing code**: Research phase should focus on understanding existing patterns
- **Use "think" modes for deeper analysis**: Trigger extended thinking for complex problems
- **Create explicit plans before implementation**: Have Claude generate structured plans that can be reviewed
- **Verify during coding**: Continuously check solution reasonableness
- **Document changes clearly**: Commit with comprehensive messages

**Key Insight**: "Without initial research and planning steps, Claude tends to jump straight to coding a solution, but asking Claude to research and plan first significantly improves performance for problems requiring deeper thinking upfront."

#### Test-Driven Development (TDD)
**Source**: Anthropic Engineering Blog - Claude Code Best Practices

- **Write tests first without implementation**: Create failing tests upfront
- **Confirm tests initially fail**: Verify test baseline
- **Implement code to pass tests**: Build the actual functionality
- **Use subagents to verify**: Prevent overfitting by having independent agents review

**Key Insight**: "Be explicit about the fact that you're doing test-driven development so that it avoids creating mock implementations, even for functionality that doesn't exist yet in the codebase."

#### Visual Iteration Approach
**Source**: Anthropic Engineering Blog - Claude Code Best Practices

- **Provide visual mocks or screenshots**: Give Claude visual targets
- **Implement and screenshot results**: Capture actual output
- **Iterate 2-3 times**: Refine based on visual comparison

### 2. 2025 Feature Updates

#### Subagents (Parallel Task Delegation)
**Source**: Anthropic Blog - Enabling Claude Code to Work More Autonomously

- **Delegate specialized tasks**: Example - "spinning up a backend API while the main agent builds the frontend"
- **Enable parallel development workflows**: Multiple agents work concurrently on different components
- **Use for verification**: Independent agents can review primary agent's work

**Implementation Pattern**:
```markdown
Task("Find authentication files", """
Use the codebase-locator agent to find all files related to authentication.
Return a list with file paths and brief descriptions.
""")

Task("Analyze auth implementation", """
Use the codebase-analyzer agent to understand how the authentication flow works.
Document the data flow and key functions.
""")
```

#### Checkpointing (Safe Experimentation)
**Source**: Anthropic Blog - Enabling Claude Code to Work More Autonomously

- **Automatic code state saving**: Saves state before changes
- **Instant rewind capability**:
  - Tap Esc twice
  - Use `/rewind` command
- **Enables ambitious tasks**: Pursue "more ambitious and wide-scale tasks" with safety net
- **Works with version control**: Complements git for finer-grained control

#### Background Tasks and Hooks
**Source**: Anthropic Blog - Enabling Claude Code to Work More Autonomously

- **Long-running processes**: Keep tasks active without blocking progress
- **Automated testing**: Hooks can automatically run test suites after code changes
- **Code quality enforcement**: Perform linting before commits
- **Event-driven automation**: Respond to specific development events

### 3. Context Engineering Best Practices

**Source**: Anthropic Engineering Blog - Effective Context Engineering for AI Agents

#### Treat Context as Finite Resource
- **"Minimal set of information"**: Provide the smallest possible set of high-signal tokens
- **"Attention budget"**: Be mindful of the model's limited attention
- **Diminishing marginal returns**: More context isn't always better

#### Prompt Structure
- **Clear, direct language at "right altitude"**: Match abstraction level to task
- **Organize into distinct sections**: Use tags like `<background_information>`, `<instructions>`
- **Self-contained, robust tools**: Tools should be clear and error-resistant

#### Dynamic Context Management Techniques
- **Just-in-time context retrieval**: Load context when needed, not upfront
- **Compaction**: Summarize conversation history
- **Structured note-taking**: Maintain persistent memory outside context window
- **Sub-agent architectures**: Delegate complex tasks to specialized agents

### 4. Environment Optimization

#### CLAUDE.md Configuration
**Source**: Anthropic Engineering Blog - Claude Code Best Practices

- **Automatic context loading**: Claude pulls CLAUDE.md into context automatically
- **Ideal for repository etiquette**: Branch naming, merge vs. rebase preferences
- **Project-specific patterns**: Document conventions, testing approaches, verification commands
- **Workflow guidance**: Define custom commands and specialized agents

#### Custom Slash Commands
**Source**: Anthropic Engineering Blog - Claude Code Best Practices

- **Repeated workflows**: Codify common patterns as reusable commands
- **Research commands**: `/project:research_codebase` for structured exploration
- **Planning commands**: `/project:create_plan` for phase-by-phase planning
- **Implementation commands**: `/project:implement_plan <file>` for execution

### 5. Tool Design Principles

**Source**: Anthropic Engineering Blog - Writing Tools for AI Agents

- **Self-contained and robust to error**: Tools should handle edge cases gracefully
- **Extremely clear**: Descriptive, unambiguous input parameters
- **Avoid bloated tool sets**: No overlapping functionality
- **Descriptive names**: Make purpose obvious from name alone

### 6. Safety and Verification

#### Permission Management
- **Be cautious with "YOLO mode"**: Unrestricted permissions can be dangerous
- **Use containers for unrestricted operations**: Isolate risky operations
- **Verify Claude's work independently**: Use multiple instances or human review

#### Continuous Verification
- **Course-correct early and frequently**: Don't let issues accumulate
- **Use checklists for complex tasks**: Break down verification into steps
- **Test suites as safety nets**: Automated testing catches regressions

### 7. Multi-Agent Architectures

**Source**: Anthropic Engineering Blog - Effective Context Engineering

- **Specialized responsibilities**: Each agent has focused purpose
  - `codebase-locator`: Find relevant files and locations
  - `codebase-analyzer`: Understand how implementations work
  - `codebase-pattern-finder`: Identify conventions and patterns
  - `test-pattern-finder`: Find testing patterns and approaches
- **Long-horizon task handling**: Break complex research into parallel sub-tasks
- **Memory persistence**: Maintain state outside context window through artifacts

### 8. Code Learning and Exploration

**Source**: Anthropic Blog - How Anthropic Teams Use Claude Code

- **Core onboarding workflow**: Using Claude Code has become Anthropic's primary onboarding method
- **Improved ramp-up time**: Significantly faster than traditional approaches
- **Reduced load on other engineers**: New team members can explore independently
- **Research-first approach**: Understand before modifying

## Code References

### Research Command Pattern
`.claude/commands/research_codebase.md` - Defines research workflow with specialized subagents

### Planning Command Pattern
`.claude/commands/create_plan.md` - Structures phase-by-phase implementation planning

### Implementation Command Pattern
`.claude/commands/implement_plan.md` - Executes plans with user approval between phases

### Agent Specialization
`AGENTS.md` - Documents available specialized subagents and their purposes

## Architecture Insights

### Research → Plan → Implement Pattern
1. **Research Phase**: Spawn parallel subagents to explore codebase
2. **Planning Phase**: Create 3-7 phase plan with verification steps
3. **Implementation Phase**: Execute plan phase-by-phase with user approval

### Subagent Task Delegation
- Multiple specialized agents work in parallel
- Each agent has focused responsibility (locator, analyzer, pattern-finder)
- Main agent synthesizes findings from subagents

### Context Window Management
- Research artifacts stored in `thoughts/research/`
- Plans stored in `thoughts/plans/`
- Shared knowledge in `thoughts/shared/`
- Keeps main context clean while maintaining memory

### Verification at Every Level
- Phase-level verification (after each implementation phase)
- Final verification (complete test suite)
- Rollback procedures for safe experimentation

## Historical Context

### Evolution from CLI Tool to Agent Platform
- **Original**: Low-level, unopinionated CLI for direct model access
- **2025 Update**: Added subagents, checkpointing, background tasks
- **SDK Rename**: Claude Code SDK → Claude Agent SDK (broader vision)

### Anthropic's Internal Adoption
- Used for onboarding new engineers
- Core workflow for code exploration and learning
- Trusted for significant refactors and feature exploration

## Related Best Practices

### From Context Engineering Research
- **Minimal high-signal context**: Quality over quantity
- **Just-in-time retrieval**: Dynamic context loading
- **Structured artifacts**: Persistent memory outside context window

### From Tool Design Research
- **Clear, unambiguous parameters**: Self-documenting tools
- **Error handling**: Robust to edge cases
- **No overlapping functionality**: Each tool has single, clear purpose

### From Autonomous Work Research
- **Checkpointing for safety**: Experiment with confidence
- **Parallel workflows**: Subagents enable concurrent development
- **Hooks for automation**: Event-driven quality enforcement

## Open Questions

1. **Optimal subagent granularity**: How many specialized agents is too many?
2. **Context window optimization**: What's the ideal balance between pre-loaded context (CLAUDE.md) and just-in-time retrieval?
3. **Verification depth**: When is automated testing sufficient vs. requiring human review?
4. **Plan complexity**: What's the sweet spot between over-planning and under-planning?

## Recommendations for Implementation

### Immediate Priorities
1. **Enhance CLAUDE.md**: Add more specific context engineering guidance
2. **Update agent commands**: Incorporate 2025 best practices (subagents, checkpointing)
3. **Improve agent specialization**: Define clearer responsibilities for each subagent
4. **Add verification patterns**: Include automated testing and rollback procedures

### Agent Command Improvements
- Add explicit context management strategies
- Include subagent spawning patterns
- Document checkpoint/rewind workflows
- Emphasize test-driven development approach

### AGENTS.md Updates
- Document subagent architecture pattern
- Explain when to use parallel vs. sequential agents
- Add examples of multi-agent coordination
- Include context engineering best practices

### Workflow Enhancements
- Add explicit "think" triggers for complex problems
- Include visual iteration patterns where applicable
- Document background task usage
- Add hook configuration examples

## Sources

1. Anthropic Engineering Blog: "Claude Code: Best practices for agentic coding"
2. Anthropic Blog: "Enabling Claude Code to work more autonomously"
3. Anthropic Engineering Blog: "Effective context engineering for AI agents"
4. Anthropic Engineering Blog: "Writing effective tools for AI agents—using AI agents"
5. Anthropic Blog: "How Anthropic teams use Claude Code"
