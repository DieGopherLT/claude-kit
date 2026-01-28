---
description: Generate/update LSP-optimized, token-efficient CLAUDE.md for module documentation. Triggers: document module, onboarding, understand business logic, claudify, module docs
argument-hint: <module-relative-path>
model: sonnet
---

You are tasked with generating comprehensive yet token-efficient documentation for the module: **$1**

**Format Philosophy**: LSP-optimized symbol references (`file::Symbol`) enable precise code navigation with zero false positives, reducing token usage while improving navigation accuracy.

## Step 0: Check for Existing Documentation

First, check if a CLAUDE.md file already exists in the $1 directory:

- Use the Read tool to attempt reading `$1/CLAUDE.md`
- If the file exists: store its content to use as baseline context for the Explore agent
- If the file does not exist: proceed with fresh exploration

## Step 1: Explore the Module

Use the Task tool with subagent_type=Explore to analyze this module with "very thorough" depth.

**Exploration prompt for the agent:**

```
Context: Documenting module at path: $1
Objective: Deep analysis to generate token-efficient CLAUDE.md documentation

[If existing CLAUDE.md was found, include this section:]
Existing Documentation:
The module already has a CLAUDE.md file with the following content:
---
[paste the existing CLAUDE.md content here]
---

Use this as baseline context. Your task is to:
- Verify the accuracy of existing information
- Update outdated sections
- Add missing information
- Improve clarity and token efficiency

[End of conditional section]

Scope:
  - Start points: $1 directory and all subdirectories
  - Include: Source files, configuration, environment variables & tests (for understanding patterns)
  - Exclude: node_modules, vendor, dist, build artifacts

Deliverables:
  1. Module purpose and role in the system
  2. Entry points (main functions, exported APIs, handlers) - reference by symbol name
  3. Key files with their specific roles
  4. Business logic workflows and decision points
  5. Internal dependencies (other modules) and external dependencies (libraries)
  6. Architecture patterns and design decisions
  7. Guidelines for modifications (where to add/remove code)
  8. Common usage patterns and pitfalls

CRITICAL: The CLAUDE.md file is your MAP. If the map is wrong, you will be lost when navigating this module. Ensure every reference is accurate and up-to-date.

Depth: very thorough
```

## Step 2: Generate/Update CLAUDE.md

Based on the exploration results, create or update the CLAUDE.md file in the $1 directory with this token-efficient structure:

```markdown
# [Module Name]

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview
[1-2 sentences: purpose and role in system]

## Entry Points
- `file::FunctionName` - [description]
- `file::ClassName.method` - [description]
- `file::exportedVariable` - [description]

## Key Files
- **file**: [role/purpose in <20 words]
- **file**: [role/purpose in <20 words]

**Note**: Symbol references use LSP-optimized format (`file::Symbol`) for:
- `goToDefinition`: Jump directly to symbol location
- `findReferences`: Find all real usages (zero false positives)
- `hover`: Get type info and documentation instantly
- `documentSymbol`: Navigate file structure without reading full content

## Business Logic
[Concise explanation of core workflows, decision logic, and state management]

## Dependencies

**Internal:**
- module: [why needed]

**External:**
- package: [purpose]

**Environment Variables:**
- `VAR_NAME`: [purpose]

## Architecture
[Key patterns, design decisions, architectural style]

## Modification Guide

### Adding Features
- [specific guideline]
- [specific guideline]

### Removing Code
- [consideration]
- [consideration]

### Common Pitfalls
- [pitfall] → [solution]

## Usage Examples

```[language]
// [brief practical example]
```

---

## Claude's Navigation Commitment

This CLAUDE.md is my map for navigating this module. I commit to:

- **Update immediately** after any code modification in this module
- **Verify accuracy** of all symbol references after each change
- **Maintain truth** - outdated documentation is a critical bug
- **Treat this as my compass** - if this map is wrong, I'm lost

Last verified: [current date]

```markdown

### Update guidelines:

- Re-write files as you were creating them from scratch.
- Do not convert CLAUDE.md into changelogs or release notes.
- Ensure the format specified above is strictly followed without deviations.
  - Tear down and rebuild existing sections if needed. Follow the exact structure.
- If any pitfalls gets solved, remove them from the list.  

### Token Efficiency Rules
- Bullet points over paragraphs
- **Symbol references**: `file::FunctionName` or `file::Class.method` format (LSP-optimized for precise navigation)
- **File references**: `relative-path` format
- **Descriptions**: <20 words
- **Focus**: "why" over "what"
- **Omit**: obvious details, focus on business logic
- **Abbreviations**: clear and consistent

**LSP Optimization Benefits:**
- **Precise navigation**: LSP resolves `file::Symbol` to exact line/character position
- **Zero false positives**: `findReferences` finds only real usages, not comments/strings
- **Token savings**: No need to read entire files - LSP provides targeted info
- **Automated verification**: Can validate symbol existence and update references programmatically

### Your Commitment
This CLAUDE.md is your navigation map for this module. You commit to:
- Keep it accurate and truthful at all times
- Update it immediately after any module modification
- Verify all symbol references remain valid
- Treat outdated documentation as a critical bug

## Step 3: Confirm

After creating or updating the CLAUDE.md file, report:

- Action taken: [created new | updated existing] CLAUDE.md
- Location of file
- Token count estimate (if new) or change summary (if updated)
- Key insights discovered
- Notable improvements made (if updating)
- Confirmation of commitment to maintain this map updated

## Final Check

Claude, this CLAUDE.md is YOUR MAP. A wrong map means you'll be lost navigating this module. Before finishing, ask yourself:

> "Is the CLAUDE.md file in the exact format as specified?" No variations allowed.
> "Is this documentation up to date & telling the absolute truth in the current state of the module?"
> "Am I referencing correctly all the symbols, functions, files, and business logic involved?"
> "Are all symbol references LSP-resolvable (can I use goToDefinition/findReferences on them)?"
> "Did I vow to be as token-efficient as possible while still being comprehensive?"
> "Did I vow to update this documentation every time the module changes in the future?"

If any question is answered NO, then keep iterating until you can answer YES with confidence.

**Pro tip**: After generating CLAUDE.md, test a few symbol references with LSP tools to verify they resolve correctly.
