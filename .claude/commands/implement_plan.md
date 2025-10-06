# Implement Plan Command

You are tasked with implementing a plan that has been created. Work through it phase-by-phase, getting user approval between phases.

## Initial Response

I'm ready to implement the plan. Please provide the path to the plan file:
- Format: `thoughts/plans/[filename].md`

Or just say "implement the latest plan" and I'll find the most recent one.

Then wait for the user's instruction.

## Implementation Process

### Step 1: Read and Understand the Plan
- Read the entire plan document
- Understand all phases and their dependencies
- Note the verification commands for each phase
- Understand the rollback strategy

### Step 2: Confirm Start
Present a summary to the user:
```
I've read the plan: [Plan Title]

This plan has [N] phases:
1. [Phase 1 name] - [Brief description]
2. [Phase 2 name] - [Brief description]
...

I'll implement each phase and pause for your verification.
Ready to start with Phase 1?
```

Wait for user confirmation.

### Step 3: Phase-by-Phase Implementation

For each phase:

#### A. Announce Phase Start
```
Starting Phase [N]: [Phase Name]

Goal: [Phase objective]
Files to modify: [list]
```

#### B. Implement Changes
- Make the changes specified in the phase
- Follow the patterns and conventions noted in the plan
- If something doesn't match expectations, STOP and inform the user

#### C. Run Verification
Execute ALL verification commands listed in the phase:
```
Running verification:
✓ npm test -- [specific test]
✓ npm run typecheck
✓ npm run lint
```

Show results to the user.

#### D. Request Approval
```
Phase [N] complete.

Changes made:
- [Summary of changes]

Verification: [All passed / Some failed]

Ready to proceed to Phase [N+1]?
Or would you like me to:
- Rollback this phase
- Make adjustments
- Explain something
```

Wait for user decision.

#### E. Handle Issues

If verification fails:
```
⚠️ Verification failed in Phase [N]

Failed check: [which command]
Error: [error message]

Options:
1. I can attempt to fix this
2. Roll back this phase (command: [rollback from plan])
3. You want to investigate manually

What would you like to do?
```

If user asks to rollback:
- Execute the rollback commands from the plan
- Verify rollback succeeded
- Report status

### Step 4: Update Plan Document

After each successful phase:
- Update the plan file
- Mark the phase as complete: `**Status**: [X] Complete`
- Add brief notes about any deviations or learnings

### Step 5: Final Verification

After all phases complete:
```
All phases complete! 🎉

Running final verification suite...
[Execute all commands from "Final Verification" section]

Results:
✓ [Command 1]
✓ [Command 2]
...

Implementation summary:
- [N] phases completed
- [M] files modified
- All verification passed

Next steps:
- Review the changes
- Test manually if needed
- Commit when satisfied
```

## Important Guidelines

### Verify Your Work
- Don't skip verification steps to save time
- If something fails, stop and consult the user
- Context matters - what worked in planning might not work in implementation

### Communicate Clearly
When things don't match the plan:
```
⚠️ Issue in Phase [N]:

Expected: [what the plan says]
Found: [actual situation]

This might mean:
- [Possible reason 1]
- [Possible reason 2]

Recommended: [What you think we should do]

How would you like to proceed?
```

### Respect User Control
- Always pause between phases for approval
- Never rush ahead assuming user wants to continue
- User can interrupt at any time to:
  - Adjust the approach
  - Ask questions
  - Rollback changes
  - Stop implementation

### Update the Plan
The plan is a living document:
- Mark phases as complete: `[X]`
- Add notes about deviations
- Document any learnings
- Keep it accurate for future reference

## Example Implementation Flow

```
User: /project:implement_plan thoughts/plans/2025-01-06-add-auth.md

Claude: I've read the plan: "Add JWT Authentication"

This plan has 4 phases:
1. Add User model types
2. Create auth service
3. Add API endpoints
4. Add tests

Ready to start with Phase 1?

User: yes

Claude: Starting Phase 1: Add User Model Types
[Makes changes]
Running verification:
✓ npm run typecheck passed
✓ Types available for import

Phase 1 complete. Ready for Phase 2?

User: yes

Claude: Starting Phase 2: Create auth service
[Makes changes]
Running verification:
✓ npm test -- AuthService.test.ts passed
✓ npm run typecheck passed

Phase 2 complete. Ready for Phase 3?

[... continues through all phases ...]
```

## Rollback Procedure

If at any point you need to rollback:

1. **Execute rollback commands from the plan**:
   ```bash
   git restore [files from rollback section]
   ```

2. **Verify rollback succeeded**:
   ```bash
   npm test
   npm run build
   ```

3. **Report status**:
   ```
   Rollback complete.
   
   All changes from Phase [N] have been reverted.
   Verification passed - system is stable.
   
   What would you like to do next?
   - Try a different approach for this phase
   - Revise the plan
   - Stop here
   ```

## Remember

- You're implementing a solution, not just checking boxes
- The plan is your guide, but judgment matters
- When in doubt, ask the user
- Verify everything before proceeding
- Keep the user informed at each step
