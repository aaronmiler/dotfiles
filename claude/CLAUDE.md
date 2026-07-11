# Global Claude Instructions

## General Principles
- Be concise; avoid unnecessary preamble and summaries
- Prefer small, focused changes
- Default to the simplest working solution; I'll ask for complexity if needed
- Avoid abstraction unless there's a clear second use case
- When adding new code, find the closest existing pattern and match it exactly
- If no clear pattern exists, ask before choosing an approach
- If you're unsure, propose 2-3 options in <5 lines each, don't deep-dive

## Workflow

### Planning
- **Simple tasks (1-2 steps):** Implement after brief confirmation; don't over-plan
- **Non-trivial tasks (3+ steps or architectural decisions):** Write a plan first, get my approval, then execute
- If something goes sideways mid-task, STOP and re-plan instead of pushing through

### Subagent Strategy
- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- One task per subagent for focused execution

### Verification Before Done
- Never mark a task complete without proving it works
- Run tests, check logs, diff behavior between main and your changes
- Describe what changed and how to verify

### Autonomous Bug Fixing
- When given a clear bug report: just fix it, don't ask for hand-holding
- Point at logs, errors, failing tests — then resolve them

### Elegance Check
- For non-trivial changes: pause and ask "is there a more elegant way?"
- Skip this for simple, obvious fixes — don't over-engineer

### When Things Go Wrong
- If an approach isn't working after 2 attempts, stop and re-plan
- Flag when a task is more complex than initially scoped
- If token usage is climbing without progress, stop and summarize where you are

## Self-Correction
- When I correct a mistake, log it in `~/.claude/LESSONS.md`
- Format: `- [project-name] [date]: lesson learned`
- Write rules for yourself that prevent the same mistake
- Review relevant lessons at the start of each session
- **If the mistake came from a skill file or CLAUDE.md, update that file before moving on**
- Ask me to confirm the update if the change affects a convention (not just a typo)

## Task Management
1. **Plan First**: Write plan with checkable items for non-trivial work
2. **Verify Plan**: Check in before starting implementation
3. **Track Progress**: Mark items complete as you go
4. **Explain Changes**: High-level summary at each step
5. **Capture Lessons**: Update LESSONS.md after corrections

## Token Management
- Use `head`, `tail`, or `rg` instead of `cat` for large files
- Limit `fd`/`ls` results with `| head -50`
- Start with structure (`tree -L 2`) before diving into files
- Summarize large command outputs instead of displaying raw

## Code Style & Conventions
- Stack-specific conventions live in skill files — always follow them
- When working in Rails: see ~/.claude/skills/rails.md
- When working in React/TS: see ~/.claude/skills/frontend.md
- When writing tests: see ~/.claude/skills/testing.md

## Security
- Never commit secrets, tokens, or credentials
- Never read secret-bearing files in full (`~/.claude/settings.json` env block, `.env*`,
  credentials files) — anything read enters context and session transcripts. Inspect
  keys first (`jq 'keys'`) and extract only the non-secret field you need
- Flag potential injection, XSS, or mass assignment issues

## Git Usage
Never perform mutative git operations (branch, commit, etc)

## Installed CLI tools

- **ripgrep** (`rg`) is installed — prefer over `grep` for shell searches
- **fd** is installed — prefer over `find` for file finding by name/pattern
- **sd** is installed — prefer over `sed` for find-and-replace in files
- **jq** is installed — use for JSON processing in shell pipelines

## Machine-Specific Instructions

Per-machine rules (work vs personal) live in `~/.claude/CLAUDE.local.md`, which is
not version-controlled:

@~/.claude/CLAUDE.local.md
