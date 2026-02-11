---
description: Quality review y refactoring con 3 reviewers paralelos (simplicity, bugs, conventions) y confidence >= 80%. Acepta directorio como alcance opcional.
argument-hint: "[directory or file path]"
allowed-tools: Read, Glob, Grep, Bash, LSP, Task, AskUserQuestion
user-invocable: true
---

# Smart Review - Quality Review & Refactoring

Execute quality review and optional refactoring on a given scope.

## Step 1: Determine Scope

If `$ARGUMENTS` is provided:

- Use it as the review scope (directory or file path)
- Verify it exists using Glob or Bash

If `$ARGUMENTS` is empty:

- Use AskUserQuestion to ask the user for the scope:
  - "Which directory or files should I review?"
  - Options: suggest common patterns like `src/`, `lib/`, or "detect from git status"
- If user chooses git status detection, run `git status --short` and `git diff --name-only HEAD` to collect modified files

## Step 2: Collect Files

Gather all relevant source files within the scope:

- Use Glob to find files matching common source patterns (`.ts`, `.tsx`, `.js`, `.jsx`, `.go`, `.cs`, etc.)
- Exclude test files, generated files, and config files unless explicitly requested
- Present file count to user before proceeding

## Step 3: Launch Parallel Reviewers

Launch 3 code-reviewer agents simultaneously:

**Reviewer 1 - Simplicity / DRY / Elegance**:

```
Task(
  subagent_type: "smart-plan:code-reviewer",
  prompt: "Review the following files for code quality:
[list of files]

Focus: simplicity, DRY principle, code elegance, unnecessary complexity.
Only report findings with confidence >= 80%.
Include concrete fix suggestions for each finding."
)
```

**Reviewer 2 - Bugs / Functional Correctness**:

```
Task(
  subagent_type: "smart-plan:code-reviewer",
  prompt: "Review the following files for bugs and logic errors:
[list of files]

Focus: bugs, logic errors, edge cases, error handling, race conditions, null safety.
Only report findings with confidence >= 80%.
Include concrete fix suggestions for each finding."
)
```

**Reviewer 3 - Conventions / Abstractions**:

```
Task(
  subagent_type: "smart-plan:code-reviewer",
  prompt: "Review the following files for convention adherence:
[list of files]

Project conventions:
[key conventions from project CLAUDE.md, package.json, or codebase patterns]

Focus: naming conventions, architectural patterns, import organization, abstraction quality.
Only report findings with confidence >= 80%.
Include concrete fix suggestions for each finding."
)
```

## Step 4: Consolidate Findings

1. Collect all findings from 3 reviewers
2. Deduplicate overlapping issues
3. Filter: keep only findings with confidence >= 80%
4. Present consolidated review to user with:
   - File path and line number
   - Issue description
   - Confidence score
   - Concrete fix suggestion

If no findings >= 80%: inform user the code passed review without critical issues. Stop here.

## Step 5: Confirm Refactoring

Use AskUserQuestion:

- "Apply automatic fixes for the N findings with confidence >= 80%?"
- Options: "Yes, apply all", "Let me pick which ones", "No, just keep the report"

If user declines: stop here and present the report as final output.

If user wants to pick: present each finding individually and let user approve/reject.

## Step 6: Apply Refactoring

Launch code-refactorer agent with approved findings:

```
Task(
  subagent_type: "smart-plan:code-refactorer",
  prompt: "Apply the following corrections to the codebase:

[list of approved findings with file paths, line numbers, and suggested fixes]

After applying ALL corrections:
1. Run build/compile check
2. Run tests (if test suite exists)
3. Run linter (if configured)

Report all changes made and validation results."
)
```

Review refactorer's report:

- If validation passed: present summary of changes to user
- If validation failed: present failures to user for decision

## Rules

- Only report findings with confidence >= 80%
- Always confirm with user before applying refactoring changes
- Be transparent about current step and actions
- Present consolidated findings, not raw agent outputs
- If an agent fails, inform user and offer retry or adjustment
- If build/test validation fails after refactoring, present failures and request guidance
