# Plan: {Feature Name}

> Repository: {repo-name}
> Role: {producer/consumer/bidirectional}
> Related: `MULTIREPO-FLOW.md`

## Summary

{Brief description of the feature and what this repository specifically implements}

## Tasks

> Created via TaskCreate for progress tracking.

| ID | Task | Status | Blocked by |
|----|------|--------|------------|
| 1 | {task 1 description} | pending | - |
| 2 | {task 2 description} | pending | 1 |
| 3 | {task 3 description} | pending | - |

## Files to Modify

| File | Action | Task |
|------|--------|------|
| {path/to/file} | Create/Modify | #1 |

## Files NOT to Touch

- {file that should not be modified and why}

## Implementation Plan

### Task 1: {title}

{Detailed description}

**Files:**

- `{path/to/file}`

**Changes:**

```{language}
// code or pseudocode of the change
```

### Task 2: {title}

{Detailed description}

---

## Multi-Repo Dependencies

### Requires from Other Repo

| Dependency | Repo | Status |
|------------|------|--------|
| {endpoint/type/resource} | {other-repo} | {Pending/Ready} |

### Provides to Other Repo

| Resource | Description |
|----------|-------------|
| {endpoint/type/event} | {what it exposes for the other repo} |

## Validation

### Unit Tests

- [ ] {test to create/modify}

### Integration Tests

- [ ] {test that validates integration with other repo}

## Notes

- {Additional considerations}
- {Relevant technical decisions}
