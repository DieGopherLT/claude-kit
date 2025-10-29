# Claude Code Custom Slash Commands Guide

> Official guide for creating effective custom slash commands in Claude Code

This guide provides best practices and technical details for authoring custom slash commands that integrate seamlessly with Claude Code.

## File Structure and Location

Custom slash commands are stored as Markdown files in two possible locations:

### Project Commands

**Location**: `.claude/commands/`

- Shared with team via git
- Version controlled with the project
- Project-specific workflows and conventions
- Committed to repository for team collaboration

### Personal Commands

**Location**: `~/.claude/commands/`

- User-level commands across all projects
- Not version controlled
- Personal productivity workflows
- Available in every Claude Code session

### Directory Organization

Commands can be organized in subdirectories for better organization:

```
.claude/commands/
├── frontend/
│   ├── component.md      # Creates /component
│   └── style.md          # Creates /style
├── backend/
│   ├── api.md            # Creates /api
│   └── test.md           # Creates /test
└── docs.md               # Creates /docs
```

**Important**: Subdirectories create namespaces for help text display but **do not affect command invocation**. A file at `.claude/commands/frontend/component.md` is still invoked as `/component`, not `/frontend/component`.

The namespace appears in `/help` output as metadata: `(project:frontend)` or `(user:backend)`.

## Naming Conventions

### Command Name Derivation

The command name comes directly from the filename without the `.md` extension:

- `optimize.md` → `/optimize`
- `review-pr.md` → `/review-pr`
- `commit-message.md` → `/commit-message`

### Naming Best Practices

**Use descriptive, action-oriented names**:
- ✅ Good: `/review-pr`, `/optimize-imports`, `/generate-docs`
- ❌ Avoid: `/helper`, `/utils`, `/do-stuff`

**Use kebab-case for multi-word commands**:
- ✅ Good: `/review-code`, `/update-deps`
- ❌ Avoid: `/reviewCode`, `/update_deps`

**Keep names concise but clear**:
- ✅ Good: `/commit`, `/review`, `/test`
- ❌ Avoid: `/c`, `/r`, `/t` (too cryptic)

**Avoid conflicts with built-in commands**:
- Check existing commands with `/help`
- Avoid names like `/help`, `/clear`, `/model`, etc.

## Frontmatter Metadata

Commands support optional YAML frontmatter for enhanced functionality and documentation.

### Available Fields

#### description

Brief explanation shown in `/help` output. Makes commands more discoverable and enables proactive invocation via triggers.

**Format**: Keep under 120 characters. Include action verb and trigger keywords.

```yaml
---
description: Review code for security vulnerabilities. Triggers: security, vulnerability, authentication, input validation
---
```

**Pattern**:
```
[ACTION VERB]: [OUTCOME in <50 chars]. Triggers: keyword1, keyword2, keyword3
```

**Examples**:
- `Analyze: Predict potential code problems. Triggers: predict, risk analysis, code smell, technical debt`
- `Generate: Create smart git commits with quality checks. Triggers: commit, stage changes, git add`
- `Refactor: Project-wide React JSX optimization. ⚠️ Full codebase operation. Triggers: migrate clsx, refactor jsx`

**Trigger Keywords**: These enable Claude to proactively invoke your command. Include natural language phrases users might say:
- Action words: create, generate, analyze, predict, refactor, explain
- Problem indicators: bug, issue, error, smell, debt, complexity
- Context words: deploy, production, scale, performance, security

**Best practice**:
- Keep main description under 120 characters
- Add warning icon `⚠️` for destructive/project-wide commands
- Triggers should be comma-separated, lowercase, specific keywords
- No descriptions longer than 2 lines in the YAML value

#### allowed-tools

Specifies which tools the command can invoke. Essential for security when using bash execution.

```yaml
---
allowed-tools: Bash(git show:*)
---
```

**Patterns**:
- `Bash(git show:*)` - Allow all `git show` commands
- `Bash(npm:*)` - Allow all npm commands
- `Read(//home/user/project/**)` - Allow reading files in project directory

**Security note**: Always constrain tool access to minimum necessary. Broad permissions like `Bash(*)` should be avoided.

#### argument-hint

Shows users expected parameters in help text and autocomplete.

```yaml
---
argument-hint: [pr-number] [priority]
---
```

**Examples**:
- `[file-path]` - Single required argument
- `[severity-level]` - Descriptive parameter name
- `[branch] [target]` - Multiple parameters
- `[message...]` - Variable number of arguments

**Best practice**: Use square brackets `[]` for required args, angle brackets `<>` for optional.

#### model

Override the default model for this specific command.

```yaml
---
model: claude-opus-4
---
```

**Use cases**:
- Heavy reasoning tasks: `claude-opus-4`
- Fast iterations: `claude-haiku-4`
- Balanced performance: `claude-sonnet-4`

#### disable-model-invocation

Prevents the `SlashCommand` tool from programmatically executing this command.

```yaml
---
disable-model-invocation: true
---
```

**Use cases**:
- Commands that should only be manually invoked
- Workflows requiring explicit user trigger
- Commands with destructive operations

### Complete Frontmatter Example

```yaml
---
description: Review pull request for security and best practices. Triggers: review pr, security review, code quality, pr analysis
argument-hint: [pr-number]
allowed-tools: Bash(gh pr view:*), Bash(gh pr diff:*)
model: claude-opus-4
---
```

## Argument Handling

Commands support two argument patterns for maximum flexibility.

### Pattern 1: Combined Arguments ($ARGUMENTS)

Captures all arguments as a single string. Best for:

- Free-form text input
- Commit messages
- Search queries
- Natural language input

**Example**:

```markdown
---
description: Generate a commit message from changes
---

Analyze the git diff and create a commit message: $ARGUMENTS

If no message is provided, analyze staged changes and suggest a message.
```

**Usage**:
```bash
/commit-message Added user authentication feature
# $ARGUMENTS = "Added user authentication feature"
```

### Pattern 2: Positional Arguments ($1, $2, $3, ...)

Reference individual parameters by position. Best for:

- Structured input
- Multiple distinct parameters
- Conditional logic based on specific arguments
- Clear parameter separation

**Example**:

```markdown
---
description: Review pull request with specific focus
argument-hint: [pr-number] [focus-area]
---

Review PR #$1 focusing on: $2

If focus-area not provided, perform general review.
```

**Usage**:
```bash
/review-pr 123 security
# $1 = "123"
# $2 = "security"
```

### Mixing Patterns

You can combine both patterns when needed:

```markdown
Create a task for user $1 with priority $2: $ARGUMENTS
```

**Usage**:
```bash
/create-task alice high Implement OAuth authentication
# $1 = "alice"
# $2 = "high"
# $ARGUMENTS = "alice high Implement OAuth authentication"
```

### Argument Best Practices

1. **Document argument expectations clearly** in the command prompt
2. **Provide defaults** for optional arguments
3. **Validate arguments** when possible (check if files exist, numbers are valid, etc.)
4. **Give helpful error messages** when arguments are missing or invalid

## Description Format: Inline with Explicit Newlines

The recommended format for multi-line descriptions uses inline text with explicit `\n` escape sequences instead of YAML folded scalars (`>` or `>-`). This approach provides better readability when viewing command metadata in searches and help output.

### Why Inline Format?

**Advantages of inline format with `\n`:**

- ✅ Descriptions are fully visible in `/help` searches and command lists
- ✅ Clear, readable structure in IDE viewers and git diffs
- ✅ Consistent with sub-agent documentation standards
- ✅ Better metadata visibility across tools

**Disadvantages of YAML folded scalars (`>` or `>-`):**

- ❌ Only shows the `>` character in search results, not the description
- ❌ Harder to read metadata in command lists
- ❌ Inconsistent with other documentation formats

### Format Comparison

**Before (using `>`):**

```yaml
description: >
  Review pull request for security vulnerabilities.

  When to use: Complex PRs needing deep analysis

  Focuses on: Authentication, input validation, access control
```

In searches, this shows only: `description: >`

**After (inline with `\n`):**

```yaml
description: Review pull request for security vulnerabilities.\n\nWhen to use: Complex PRs needing deep analysis\n\nFocuses on: Authentication, input validation, access control
```

In searches, this shows the full description with proper formatting.

### How to Write Inline Descriptions

**Paragraph breaks:** Use `\n\n` (double newline)

```yaml
description: First paragraph.\n\nSecond paragraph.
```

**Lists:** Use `\n-` for each item

```yaml
description: Main description.\n\nItems:\n- Item one\n- Item two\n- Item three
```

**Bold text:** Use `**text**` for emphasis

```yaml
description: Overview.\n\n**Focus areas:**\n- Security\n- Performance
```

### Migration Guide

If you have existing commands with `>` or `>-` descriptions:

1. Copy the description text
2. Remove indentation (YAML adds 2-space indent with `>`)
3. Replace actual line breaks with `\n`
4. Replace blank lines with `\n\n`
5. Test the description appears correctly in `/help`

## Advanced Features

### Bash Execution

Commands can execute shell operations directly. Requires `allowed-tools` permission.

**Example**:

```yaml
---
description: Show recent commits for current branch
allowed-tools: Bash(git log:*)
---

!git log --oneline -10

Review the above commits and summarize recent changes.
```

The `!` prefix executes the bash command before processing the rest of the prompt.

**Security considerations**:
- Always declare permissions via `allowed-tools`
- Use specific command patterns, not wildcards
- Validate user input before passing to bash
- Consider potential command injection risks

### File References

Use `@` prefix to include file contents in commands.

**Example**:

```markdown
---
description: Review file for code quality issues
---

Review @$1 for:
- Code style consistency
- Potential bugs
- Performance issues
- Documentation quality
```

**Usage**:
```bash
/review-file src/components/Button.tsx
# Includes contents of Button.tsx
```

**Best practices**:
- Verify files exist before referencing
- Be mindful of file size (large files consume context)
- Use glob patterns for multiple files when appropriate

### Extended Thinking

Include thinking mode keywords to enable deeper reasoning for complex commands.

**Example**:

```markdown
---
description: Analyze architecture and suggest improvements
model: claude-opus-4
---

think

Analyze the current project architecture:
- Review directory structure
- Identify design patterns
- Evaluate separation of concerns
- Suggest architectural improvements
```

The `think` keyword triggers extended reasoning mode.

**When to use**:
- Complex analysis tasks
- Architectural decisions
- Multi-step problem solving
- Trade-off evaluation

## Best Practices

### Focus on Single, Reusable Workflows

**Good**: Commands that do one thing well
```markdown
# /optimize-imports
Organize and optimize import statements in the current file
```

**Avoid**: Commands that try to do too much
```markdown
# /fix-everything
Fix imports, format code, run tests, update docs, and deploy
```

### Provide Clear Descriptions

Make commands discoverable through good documentation and enable proactive invocation:

**Good** (with triggers for proactive invocation):
```yaml
description: Review pull request for security and best practices. Triggers: review pr, security review, code quality
argument-hint: [pr-number]
```

**Avoid** (vague descriptions without triggers):
```yaml
description: Reviews stuff
```

**Better than good** (includes warning for critical operations):
```yaml
description: Project-wide React JSX refactoring (clsx + conditionals). ⚠️ Full codebase operation. Triggers: migrate clsx, refactor jsx
model: haiku
```

### Use Frontmatter to Constrain Tool Access

Maintain security by limiting permissions:

**Good**:
```yaml
allowed-tools: Bash(git show:*), Bash(git diff:*)
```

**Avoid**:
```yaml
allowed-tools: Bash(*)
```

### Test with Different Argument Combinations

Ensure robustness by testing edge cases:

- No arguments provided
- Wrong number of arguments
- Invalid argument values
- Special characters in arguments

### Organize Commands by Domain

Use subdirectories for logical grouping:

```
.claude/commands/
├── git/
│   ├── commit.md
│   ├── review-pr.md
│   └── branch-cleanup.md
├── testing/
│   ├── run-tests.md
│   └── coverage.md
└── docs/
    ├── generate.md
    └── review.md
```

## Common Patterns

### PR Review Command

```yaml
---
description: Review pull request for security and code quality. Triggers: review pr, security review, code quality, pr analysis
argument-hint: [pr-number]
allowed-tools: Bash(gh pr view:*), Bash(gh pr diff:*)
model: claude-opus-4
---

Review PR #$1:

1. Analyze code changes for:
   - Security vulnerabilities
   - Performance implications
   - Code style consistency
   - Test coverage

2. Provide actionable feedback with:
   - Specific line references
   - Concrete improvement suggestions
   - Priority levels (critical/important/minor)
```

### Commit Message Generator

```yaml
---
description: Generate conventional commit message from staged changes. Triggers: commit, stage changes, git add, commit message
allowed-tools: Bash(git diff:*)
---

!git diff --staged

Based on the above changes, generate a commit message following conventional commits format:

- type(scope): brief description
- Detailed explanation if needed
- Breaking changes if applicable
```

### Code Review Command

```markdown
---
description: Review code for quality, bugs, and improvements. Triggers: review, code review, refactor, quality, improve code
argument-hint: [path]
---

Review @$1 for:

**Code Quality**:
- Naming conventions
- Function complexity
- Code duplication

**Potential Issues**:
- Edge cases
- Error handling
- Resource leaks

**Improvements**:
- Performance optimizations
- Readability enhancements
- Documentation gaps
```

### Batch File Processing

```yaml
---
description: Process multiple files with a specific operation. Triggers: batch process, find and replace, transform files, apply to all
argument-hint: [pattern] [operation]
allowed-tools: Bash(find:*)
---

!find . -name "$1" -type f

Apply operation "$2" to the files above:

For each file:
1. Read current contents
2. Apply transformation
3. Show proposed changes
4. Ask for confirmation before modifying
```

## Security Considerations

### Principle of Least Privilege

Only grant necessary permissions:

```yaml
# Good - Specific permissions
allowed-tools: Bash(git status:*), Bash(git diff:*)

# Avoid - Overly broad permissions
allowed-tools: Bash(*)
```

### Input Validation

Validate and sanitize user input:

```markdown
Check if PR number $1 is valid (numeric, positive)

If not valid, show error and usage example.
```

### Avoid Command Injection

Be cautious with bash execution and user input:

```markdown
# Risky - Direct user input in bash
!git commit -m "$ARGUMENTS"

# Safer - Validate and constrain input
Validate commit message format, then create commit:
- Check for conventional commits pattern
- Verify message length
- Escape special characters
```

### Audit Tool Permissions

Regularly review `allowed-tools` declarations:

- Remove unused permissions
- Narrow overly broad patterns
- Document why each permission is needed

## Troubleshooting

### Command Not Appearing in /help

**Possible causes**:
1. File doesn't have `.md` extension
2. File is in wrong directory
3. Filename contains invalid characters
4. Syntax error in frontmatter

**Solution**: Check filename, location, and YAML syntax.

### Arguments Not Working

**Possible causes**:
1. Using `$ARGUMENTS` when expecting positional args
2. Missing argument-hint documentation
3. Special characters in arguments

**Solution**: Test with simple arguments first, then add complexity.

### Bash Commands Failing

**Possible causes**:
1. Missing `allowed-tools` declaration
2. Permission pattern doesn't match command
3. Command syntax error

**Solution**: Check `allowed-tools` pattern, test command in terminal first.

### File References Not Loading

**Possible causes**:
1. Missing `@` prefix
2. File path incorrect
3. File doesn't exist

**Solution**: Verify file exists, check path is relative or absolute as needed.

## Next Steps

- Create your first custom command
- Explore existing commands in `.claude/commands/`
- Share useful commands with your team via project commands
- Combine commands with skills for powerful workflows
