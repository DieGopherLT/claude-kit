---
description: Create structured development memory entry based on recent development work. Triggers: journal, save memory, document work session, save progress
model: sonnet
---

# Journal Command for Claude Code

## Command Definition

**Purpose**: Create a structured memory entry based on recent development work

## Behavior

1. **Auto-detect Context**: Extract project name from current directory/git repository
2. **Gather Recent Changes**: Analyze recent commits and modified files and knowledge generated during the session
3. **Generate Memory**: Create formatted memory entry using available context

## Memory title

<date>_<descriptive-title>.md

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

- {prompt_user_for_problem_description}

## Solution Summary

- {prompt_user_for_solution_bullets}

## Technical Implementation

### Files Modified

- {analyze_recent_git_changes_or_prompt}

### Key Decisions

- {prompt_user_for_technical_decisions}

## Testing/Verification

- {prompt_user_for_testing_approach}

## Technical Debt

- {prompt*user_for_debt_or_default_to*"nada"}

## Related

- **Commits**: {get_recent_commit_hashes}
- **Dependencies**: {prompt_user_for_related_work}
```

## Auto-Generated Content

The command should intelligently populate:

- **Timestamp**: Current datetime
- **Project**: Git repository name or current directory
- **Files Modified**: Recent git changes analysis
- **Commits**: Last 1-3 commit hashes
- **Problem Statement**: Inferred from recent commit messages and code changes
- **Solution Summary**: Extracted from commit messages and file modifications
- **Key Decisions**: Analyzed from code patterns and architectural changes
- **Testing**: Detected test files or testing patterns in recent changes

## Smart Analysis

Based on recent development context:

- Parse commit messages for problem/solution insights
- Analyze file changes to identify implementation patterns
- Detect testing approaches from modified test files
- Identify technical debt from TODO comments or code complexity

## Error Handling

- Validate project context (ensure we're in a valid project directory)
- Check Serena connectivity before attempting to create memory
- Provide clear error messages if git history is unavailable
- Default to minimal template if automated analysis fails
- Graceful degradation when context detection is incomplete
