---
description: Create smart git commits with quality checks. Triggers: commit, stage changes, git add
argument-hint: 'short' | 'detailed'
---

# Smart Git Commit

I'll analyze your changes and create a meaningful commit message.

**Usage:**

- `/commit` or `/commit short` - Single-line commit message
- `/commit detailed` - Multi-line commit with bulleted changes

**Pre-Commit Quality Checks:**
Before committing, I'll verify:

- Build passes (if build command exists)
- Tests pass (if test command exists)
- Linter passes (if lint command exists)
- No obvious errors in changed files

First, let me validate the format argument and check if this is a git repository:

```bash
# Detect format preference (default: short)
FORMAT="${1:-short}"

if [[ "$FORMAT" != "short" && "$FORMAT" != "detailed" ]]; then
    echo "Error: Invalid format. Use 'short' or 'detailed'"
    echo "Usage: /commit [short|detailed]"
    exit 1
fi

echo "Commit format: $FORMAT"
```

Now checking repository status and changes:

```bash
# Verify we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not a git repository"
    echo "This command requires git version control"
    exit 1
fi

# Check if we have changes to commit
if ! git diff --cached --quiet || ! git diff --quiet; then
    echo "Changes detected:"
    git status --short
else
    echo "No changes to commit"
    exit 0
fi

# Show detailed changes
git diff --cached --stat
git diff --stat
```

Now I'll analyze the changes to determine:

1. What files were modified
2. The nature of changes (feature, fix, refactor, etc.)
3. The scope/component affected

If the analysis or commit encounters errors:

- I'll explain what went wrong
- Suggest how to resolve it
- Ensure no partial commits occur

```bash
# If nothing is staged, I'll stage modified files (not untracked)
if git diff --cached --quiet; then
    echo "No files staged. Staging modified files..."
    git add -u
fi

# Show what will be committed
git diff --cached --name-status
```

Based on the analysis, I'll create a conventional commit message in your chosen format:

**Format: SHORT** (single-line header only)

```
type(scope): clear description in present tense
```

Example: `git commit -m "fix(auth): resolve login timeout issue"`

**Format: DETAILED** (header + bulleted changes)

```
type(scope): clear description in present tense

- Specific change 1
- Specific change 2
- Specific change 3
```

Example:

```
git commit -m "feat(auth): add JWT token validation

- Add token expiry check in middleware
- Implement refresh token rotation
- Update error messages for expired tokens"
```

The commit message will be concise, meaningful, and follow your project's conventions if I can detect them from recent commits.

**Important**: I will NEVER:

- Add "Co-authored-by" or any Claude signatures
- Include "Generated with Claude Code" or similar messages
- Modify git config or user credentials
- Add any AI/assistant attribution to the commit
- Use emojis in commits, PRs, or git-related content

The commit will use only your existing git user configuration, maintaining full ownership and authenticity of your commits.
