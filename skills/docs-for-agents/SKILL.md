---
name: docs-for-agents
description: Automatically invoked when user wants to create or update project documentation (README.md, CLAUDE.md, AGENTS.md). Triggers include document project, create docs, update docs, setup documentation, generate README, create AGENTS.md. Creates token-efficient documentation structure with business-focused README (overview, business model, differentiators, roadmap), minimal CLAUDE.md entry point, and comprehensive AGENTS.md technical guidelines. Orchestrates 3-4 parallel Explore agents to analyze codebase patterns, naming conventions, antipatterns, and project structure. Generates compact directory trees in Quick Reference instead of verbose architecture sections. Checks for existing documentation first and uses as base for updates. Idempotent and safe for multiple runs.
---

# Project Documentation Generator

Creates or updates comprehensive project documentation with token-efficient structure optimized for Claude Code agents.

## Purpose

Generates three core documentation files:

- **README.md**: Business perspective (overview, business model, differentiators, roadmap, stakeholders)
- **CLAUDE.md**: Minimal entry point with references to other docs
- **AGENTS.md**: Token-efficient technical guidelines with consolidated development standards

## Workflow

### Phase 0: Existence Check & Mode Detection

**Before any analysis:**

1. Check if `README.md` exists → read and use as base if present
2. Check if `CLAUDE.md` exists → preserve references if present
3. Check if `AGENTS.md` exists → use structure as foundation if present

**Determine operation mode:**

- All exist → **UPDATE MODE**: Refresh content with new analysis
- Some exist → **HYBRID MODE**: Create missing, update existing
- None exist → **CREATE MODE**: Generate all from scratch

**Inform user** which mode is active before proceeding.

### Phase 1: README.md Strategy

**If README.md exists:**

- Read and analyze current content
- Ask user if update is needed
- Preserve user customizations

**If README.md missing:**

- Create with business-focused structure

**README.md Focus:**

- Business perspective and value proposition
- Project overview, target market, core functionality
- Business model, differentiators, competitive advantages
- Technology stack overview and strategic roadmap
- Team structure and key stakeholders

### Phase 2: Parallel Codebase Analysis with Explore Agents

**Deploy 3-4 Explore agents (medium thoroughness) in parallel using Task tool.**

**Agent prompts**: See `agent-prompts.md` for detailed instructions for each agent:

- **Agent 1: Code Patterns** → Development Standards section
- **Agent 2: Quality Analysis** → Antipatterns to Address section
- **Agent 3: Project Structure** → Compact directory tree for Quick Reference
- **Agent 4: Build & Tooling** → Essential Commands + Build & Development section

**Each agent receives:**

- Current codebase state
- Existing documentation (if any) as context
- Instructions to preserve good existing content
- Specific prompts from `agent-prompts.md`

### Phase 3: Documentation Generation

**Create/Update only these files:**

- README.md (if missing or needs update)
- CLAUDE.md (minimal references)
- AGENTS.md (token-efficient technical guide)

**NO additional directories** - all technical information consolidated into AGENTS.md

### Phase 4: Content Structure

**Documentation templates**: See `templates/` directory for complete templates:

- `templates/CLAUDE.md` - Minimal entry point structure
- `templates/AGENTS.md` - Complete technical guidelines structure
- `templates/README.md` - Business-focused documentation structure

**Key points:**

- **CLAUDE.md**: Uses `@README.md` and `@AGENTS.md` syntax for file references
- **AGENTS.md**: Uses standard markdown links, includes placeholders for agent outputs
- **README.md**: Business perspective (overview, business model, differentiators, roadmap, team)

### Phase 5: Token Efficiency Guidelines

**Apply these principles:**

- **Compact directory trees** with inline comments (max 15-20 lines)
- **Consolidated Development Standards** (3 subsections vs 3 separate sections)
- **No redundant documentation hierarchy** - everything in AGENTS.md
- **Quick Reference as orientation hub** vs scattered information
- **Reuse existing content** where applicable during updates

### Phase 6: Update Strategy

**When updating existing documentation:**

- Preserve user customizations in README.md - ask before significant changes
- Maintain CLAUDE.md minimal structure - only update references if needed
- Refresh AGENTS.md with new analysis while preserving manually added notes
- Ask before overwriting significant existing content
- Merge agent findings with existing sections intelligently

### Phase 7: Validation & Completion

**Verify:**

- AGENTS.md is not ignored by git (check .gitignore)
- Directory tree in Quick Reference is compact (max 15-40 lines, shell syntax)
- File references use correct syntax:
  - CLAUDE.md: @<relative-path>
  - AGENTS.md: regular markdown syntax
- All three files created/updated successfully

**Provide summary:**

- What mode was used (CREATE/UPDATE/HYBRID)
- What files were created or updated
- Suggestions for immediate next steps

## Implementation Notes

- Skill is idempotent (safe to run multiple times)
- Always check for existing files first
- Prioritize token efficiency in all generated content
- Code snippets allowed in AGENTS.md to provide examples
- Document patterns and principles, not specific implementations
- Focus on maintainable, discoverable documentation
- Ensure Claude can efficiently process the generated structure

## Success Criteria

- Stakeholders understand business context quickly (README.md)
- Claude agents find technical context efficiently (AGENTS.md)
- CLAUDE.md serves as clear entry point with minimal maintenance
- Documentation remains current through gradual updates
- Token usage is minimized (no verbose architecture sections)
- Compact directory tree provides orientation without bloat
- Antipatterns identified for systematic improvement
- Existing documentation respected and enhanced, not replaced
- Safe to run multiple times for updates
