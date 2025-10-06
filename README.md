# Agentic Codespace Base

Minimal Codespaces setup for AI-assisted development using HumanLayer's research → plan → implement workflow.

## What This Is

A secure, sandboxed foundation for working with Claude Code using context engineering principles:
- ✅ Research codebase patterns before coding
- ✅ Create detailed, phase-by-phase plans
- ✅ Implement with verification at each step
- ✅ Manual control - you approve each phase
- ✅ Network firewall - restricts access to approved domains only
- ✅ No autonomous loops - you're in charge

## Setup

### 1. Create Codespace
Click "Code" → "Create codespace on main"

### 2. Add API Key
**Settings** → **Codespaces** → **New secret**
- Name: `ANTHROPIC_API_KEY`
- Value: Your Claude API key (starts with `sk-ant-`)

### 3. Rebuild Container
After adding the secret, rebuild: **Ctrl/Cmd+Shift+P** → "Rebuild Container"

The container will:
- Build a secure development environment with Node.js 20
- Install Claude Code and development tools
- Configure network firewall to restrict outbound connections
- Set up zsh with powerline10k theme

### 4. Verify Setup
```bash
npm run check
```

Should show Claude Code version and confirm it's ready.

## Quick Start

### Basic Workflow

```bash
# Start Claude Code
claude

# Inside Claude, research the codebase
> /project:research_codebase
# "How does authentication work?"

# Review the research in thoughts/research/

# Create a plan
> /project:create_plan
# "Add password reset functionality"

# Review the plan in thoughts/plans/

# Implement the plan
> /project:implement_plan thoughts/plans/[your-plan].md

# Approve each phase as Claude implements
```

### Manual Usage

You can also use Claude Code normally:
```bash
claude explain src/
claude edit src/auth/
```

## Workflow Details

### 1. Research Phase

**Goal**: Understand the codebase before making changes

**Command**: `/project:research_codebase`

**What it does**:
- Spawns specialized subagents to search the codebase
- Documents existing patterns and conventions
- Creates a technical map of relevant code
- Outputs to `thoughts/research/[date]-[topic].md`

**Key principle**: Research documents what exists, without critiquing or suggesting improvements.

### 2. Planning Phase

**Goal**: Create a clear, verifiable implementation plan

**Command**: `/project:create_plan`

**What it does**:
- Reads research to understand patterns
- Breaks work into 3-7 atomic phases
- Specifies exact files and verification steps for each phase
- Documents rollback strategy
- Outputs to `thoughts/plans/[date]-[topic].md`

**Key principle**: Plans are specific, verifiable, and follow discovered patterns.

### 3. Implementation Phase

**Goal**: Execute the plan with verification at each step

**Command**: `/project:implement_plan thoughts/plans/[file].md`

**What it does**:
- Implements one phase at a time
- Runs verification after each phase
- Pauses for your approval between phases
- Updates the plan with progress
- Rolls back if verification fails

**Key principle**: You stay in control - approve/reject each phase.

## Directory Structure

```
.claude/
  commands/          # Workflow commands
  CLAUDE.md          # Repository context

.devcontainer/
  Dockerfile         # Container with Node 20, firewall tools, Claude Code
  devcontainer.json  # VS Code container configuration
  init-firewall.sh   # Network security rules

thoughts/
  research/          # Research documents
  plans/             # Implementation plans
  shared/            # Notes and documentation
```

## Specialized Subagents

During research, Claude uses these agents to keep context clean:

- **codebase-locator**: Finds relevant files
- **codebase-analyzer**: Understands how code works
- **codebase-pattern-finder**: Identifies conventions
- **test-pattern-finder**: Finds testing patterns

You don't call these directly - they're used automatically during research.

## Security Features

### Network Firewall

The devcontainer includes an automatic firewall (`init-firewall.sh`) that restricts network access to only approved domains:

**Allowed Domains:**
- **GitHub**: Web, API, and Git operations
- **npm**: Package registry (`registry.npmjs.org`)
- **Anthropic**: API access (`api.anthropic.com`)
- **VS Code**: Marketplace and updates
- **Telemetry**: Sentry, Statsig (for Claude Code)
- **Local Network**: Host machine and container network

**Blocked:** All other outbound connections

The firewall uses `iptables` and `ipset` to enforce these rules. It automatically initializes on container start and verifies proper configuration.

### Why This Matters

Network isolation provides:
- **Security**: Prevents unintended external connections
- **Control**: You know exactly what domains Claude Code can access
- **Transparency**: Firewall script is readable and modifiable
- **Verification**: Automatic tests confirm firewall is working

To modify allowed domains, edit `.devcontainer/init-firewall.sh` and rebuild the container.

## Example Session

```bash
$ claude

> /project:research_codebase
How does user authentication currently work in this codebase?

[Claude spawns subagents and researches]
[Writes thoughts/research/2025-01-06-auth-analysis.md]

I've completed the research. The codebase uses JWT-based authentication
with the following patterns:
- AuthService in src/auth/
- Token management in src/auth/TokenManager.ts
- Tests follow Jest + Supertest pattern

Would you like me to create an implementation plan based on this research?

> /project:create_plan
Add password reset functionality following the existing auth patterns

[Claude thinks through the approach]
[Writes thoughts/plans/2025-01-06-password-reset.md]

I've created a 5-phase plan:
1. Add password reset types
2. Create reset token service
3. Add API endpoints
4. Implement email sending
5. Add tests

Ready to review the plan?

> yes
[You read thoughts/plans/2025-01-06-password-reset.md]

> /project:implement_plan thoughts/plans/2025-01-06-password-reset.md

[Claude implements Phase 1]
Phase 1 complete. Verification passed.
Ready for Phase 2?

> yes

[Claude implements Phase 2]
Phase 2 complete. Verification passed.
Ready for Phase 3?

> yes

[... continues through all phases ...]

All phases complete! 
Tests passing, type checking passed, ready for review.
```

## Tips

### Do This
- ✅ Research before planning - understand existing patterns
- ✅ Review plans before implementing - catch issues early
- ✅ Verify after each phase - don't skip verification
- ✅ Keep plans focused - 3-7 phases is ideal
- ✅ Use subagents during research - keeps context clean

### Don't Do This
- ❌ Skip research phase - you'll miss important patterns
- ❌ Rush through phases - verification is critical
- ❌ Make plans too large - break into smaller tasks
- ❌ Ignore failures - rollback and adjust approach

## Customization

### Add Your Commands

Create custom commands in `.claude/commands/`:

```markdown
# .claude/commands/my-custom-command.md

You are tasked with [custom task].

[Instructions...]
```

Use it: `/project:my-custom-command`

### Update CLAUDE.md

Add project-specific context to `.claude/CLAUDE.md`:
- Verification commands for your stack
- Code style guidelines
- Testing patterns
- Any quirks or gotchas

### Create Custom Loops (Later)

Once comfortable with the workflow, create your own loops:

```bash
# scripts/upgrade-deps.sh
for dep in $(npm outdated --json | jq -r 'keys[]'); do
  echo "/project:create_plan upgrade $dep" | claude
  # Review plan
  # Decide to proceed or skip
done
```

## Container Features

The devcontainer includes:

**Tools:**
- Node.js 20 (LTS)
- Claude Code (latest)
- Git with delta (better diffs)
- GitHub CLI (`gh`)
- Zsh with powerline10k theme
- fzf (fuzzy finder)
- jq (JSON processor)
- Editors: nano (default), vim

**Security:**
- Network firewall with domain whitelisting
- Non-root user (`node`) with limited sudo access
- iptables and ipset for packet filtering

**Persistence:**
- Bash/zsh history across sessions
- Claude config stored in volume
- Workspace mounted with delegated consistency

## Troubleshooting

**"Command not found: claude"**
```bash
npm i -g @anthropic-ai/claude-code
# Or rebuild container
```

**"API key not found"**
- Add `ANTHROPIC_API_KEY` as Codespaces Secret
- Rebuild container to load it

**"Context window filling up"**
- Use subagents during research (they keep your context clean)
- Use `/clear` between unrelated tasks
- Keep plans focused (3-7 phases)

**"Verification failing"**
- Review the plan - might be incorrect assumptions
- Rollback the phase and adjust approach
- Consider re-running research

**"Firewall blocking legitimate domain"**
- Edit `.devcontainer/init-firewall.sh`
- Add domain to the allowed list
- Rebuild container: **Ctrl/Cmd+Shift+P** → "Rebuild Container"

**"Container build failing"**
- Check Docker/Codespaces logs for specific errors
- Ensure `NET_ADMIN` and `NET_RAW` capabilities are available
- Verify all build arguments are set correctly

## Learn More

### Anthropic Resources
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) - Core agentic coding workflows
- [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) - How to optimize context usage
- [Writing Effective Tools for AI Agents](https://www.anthropic.com/engineering/writing-tools-for-agents) - Tool design principles
- [Enabling Claude Code to Work More Autonomously](https://www.anthropic.com/news/enabling-claude-code-to-work-more-autonomously) - Subagents, checkpointing, hooks
- [How Anthropic Teams Use Claude Code](https://www.anthropic.com/news/how-anthropic-teams-use-claude-code) - Real-world usage patterns

### Community Resources
- [HumanLayer's Advanced Context Engineering for Coding Agents](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/ace-fca.md) - Detailed context engineering approach
- [HumanLayer Repo](https://github.com/humanlayer/humanlayer) - Source of workflow patterns

## License

MIT
