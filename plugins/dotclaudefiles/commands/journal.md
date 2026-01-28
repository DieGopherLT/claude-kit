---
description: Create session journal entry capturing knowledge and progress
model: sonnet
allowed-tools: Read, Bash(git:*)
---

Create a session journal entry documenting the valuable knowledge generated during this conversation.

## Context Gathering

Run these commands to detect project information:

```bash
basename $(git rev-parse --show-toplevel 2>/dev/null || pwd)
git branch --show-current 2>/dev/null || echo "n/a"
git log -1 --oneline 2>/dev/null || echo "n/a"
```

## Content Generation

Analyze the conversation to extract:

1. **Main Accomplishments**: What was achieved during this session
2. **Key Knowledge**: Important discoveries, patterns, or insights
3. **Technical Details**: Solutions implemented, approaches taken
4. **Decisions Made**: Important choices and their rationale
5. **Next Steps**: Natural continuation points or pending items

## Journal Structure

Create a journal entry with this structure:

```markdown
# {concise_session_summary}

## Session Info

- **Date**: {YYYY-MM-DD HH:MM:SS}
- **Project**: {project_name}
- **Branch**: {git_branch if available}
- **Commit**: {latest_commit_hash if available}

## What We Accomplished

{bullet_list_of_main_achievements}

## Key Knowledge

{important_insights_patterns_or_discoveries}

## Technical Details

{implementation_details_code_changes_approaches_used}

## Decisions

{important_decisions_made_with_brief_rationale}

## Next Steps

{natural_continuation_points_or_todos}

## References

{relevant_files_commits_or_resources}
```

## File Naming and Storage

**Filename format**: `YYYYMMDD-HHMMSS-{topic-slug}.md`

Example: `20260115-143022-retry-pattern-implementation.md`

**Default location**: Project root directory

**Topic slug**: Create from main session topic (lowercase, hyphens, 2-4 words)

## Content Guidelines

- Focus on knowledge and insights, not just changes
- Be concise but informative (aim for 200-400 words)
- Include specific technical details when relevant
- Omit empty sections
- Link to files using relative paths when referencing code

## Example Output

```markdown
# Implemented Exponential Backoff Retry Pattern

## Session Info

- **Date**: 2026-01-15 14:30:22
- **Project**: payment-service
- **Branch**: feature/retry-pattern
- **Commit**: a3f7d92

## What We Accomplished

- Implemented exponential backoff retry pattern for HTTP client
- Added configurable retry parameters (max attempts, delays, multiplier)
- Created comprehensive tests for retry logic
- Documented pattern usage in team wiki

## Key Knowledge

The exponential backoff pattern significantly improves resilience against transient failures. Key insight: using a multiplier of 2.0 with max delay cap prevents indefinite waiting while still giving services time to recover.

## Technical Details

Implementation in `internal/http/client.go`:
- `RetryConfig` struct for configuration
- `doWithRetry()` method with exponential delay calculation
- Distinguishes retryable (5xx) from non-retryable errors
- Respects max delay cap to prevent excessively long waits

## Decisions

- Chose 3 max attempts as default (balances reliability vs latency)
- Set max delay to 30 seconds (prevents unbounded waiting)
- Made retry behavior configurable per endpoint (flexibility for different SLAs)

## Next Steps

- Monitor retry metrics in production
- Consider adding jitter to prevent thundering herd
- Document pattern for other services to adopt

## References

- `internal/http/client.go` - Core implementation
- `internal/http/client_test.go` - Test coverage
- Commit a3f7d92 - Initial implementation
```

Write the journal entry to the project root with the formatted filename.
