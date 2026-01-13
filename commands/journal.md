---
description: Create structured development memory entry based on recent development work. Triggers: journal, save memory, document work session, save progress
model: sonnet
---

# Journal Command for Claude Code

## Command Definition

**Purpose**: Create a structured memory entry based on recent development work for documentation and future reference.

## Behavior

1. **Auto-detect Context**: Extract project name from current directory/git repository
2. **Gather Recent Changes**: Analyze recent commits and modified files and knowledge generated during the session
   1. If no git changes done recently, then work with the knowledge available in the session
3. **Generate Memory**: Create formatted memory entry using available context

## Memory title

<conversation_name>-<timestamp>.md

Save on root directory unless user specifies otherwise.

## Template Structure

```markdown
# {title}

## Context

- **Timestamp**: {current_timestamp}
- **Project**: {auto_detected_project_name}
- **Task Type**: {task_type}
- **Duration**: {duration}

## Problem Statement

- {problem_description}

## Solution Summary

- {overview_of_solution_agreed_by_user}

## Technical Implementation

### Files Modified

- {analyze_recent_git_changes_or_prompt}
- Omit if no files were changed

### Key Decisions

- {key_decisions_made_by_user_or_agent}

## Testing/Verification

- {prompt_user_for_testing_approach}
- Omit if no testing was done

## Technical Debt

- {prompt*user_for_debt_or_default_to*"nada"}
- Omit if no technical debt was identified

## Related

- **Commits**: {get_recent_commit_hashes} (skip if none)
- **Dependencies**: {prompt_user_for_related_work} (skip if none)
- **References**: {prompt_user_for_references}
```
