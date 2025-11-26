---
name: create-command
description: Automatically invoked when user wants to create, improve, update, or review Claude Code slash commands. Use when user mentions creating custom commands, slash commands, improving command metadata, fixing command YAML frontmatter, or before creating new slash command. Triggers include create command, new command, slash command, improve command, update command, review command, fix command metadata, command not working. Ensures commands have meaningful metadata with clear trigger words explaining manual invocation, descriptive purpose, minimum 512 character descriptions, proper YAML syntax validation, correct argument handling. Analyzes existing commands to avoid duplicates, suggests improvements, validates naming, handles arguments ($ARGUMENTS, $1, $2), bash execution capabilities, file references (@ prefix), namespacing via subdirectories. Handles personal (~/.claude/commands/) and project (.claude/commands/) commands, asks about supporting files case-by-case, provides preview before creating or modifying.
---

# Create Command Workflow

You are helping the user create or improve a Claude Code slash command. Follow this workflow carefully.

📚 **Reference**: This workflow follows [Claude Code Commands Guide](references/claude-code-commands-guide.md)

## Step 1: Verify Existence

Search for the command in both locations:

- Personal: `~/.claude/commands/`
- Project: `.claude/commands/`

Use `Glob` to search for existing commands: `**/*.md`

**If command exists:**

- Read the current command file
- Analyze the YAML frontmatter if present (description, model)
- Ask what the user wants to improve/fix

**If command does NOT exist:**

- If the user already stated how to scope the command (personal vs project), skip the next question.
- Use `AskUserQuestion` to ask if this should be:
  - Personal command (`~/.claude/commands/`) - available across all projects
  - Project command (`.claude/commands/`) - shared with team via git

## Step 2: Analyze Context

Before proceeding, analyze existing commands to:

- Avoid duplicate names or similar functionality
- Check for naming conflicts
- Understand existing patterns in the codebase

Use `Glob` and `Read` to examine existing commands in both locations.

📖 **Best Practice**: See [Naming Conventions](references/claude-code-commands-guide.md#naming-conventions) - filename becomes command name (without .md)

**Check for namespacing needs:**

- Ask if this command should be in a subdirectory (namespace)
- Example: `.claude/commands/frontend/component.md` creates `/component` with metadata "(project:frontend)"

## Step 3: Gather Information (Iterative)

Use a combination of `AskUserQuestion` (for multiple choice) and open questions (for free text).
**Omit all questions about information the user has already provided**.

**Questions to ask:**

1. What is the purpose of this command? (open question)
2. When should the user invoke this command manually? (use `AskUserQuestion` to suggest common invocation scenarios)
3. Does this command need arguments? (use `AskUserQuestion`)
   - If yes: ask about argument structure ($ARGUMENTS, $1, $2, etc.)
4. Does this command need to execute bash commands? (use `AskUserQuestion`)
   - If yes: explain bash execution capabilities in slash commands
5. Does this command need to reference files? (use `AskUserQuestion`)
   - If yes: explain the @ prefix usage
6. Should this command use a specific model? (use `AskUserQuestion`)
7. Does this command need namespacing (subdirectory)? (use `AskUserQuestion`)
8. Does this command need supporting files? (use `AskUserQuestion`)

📖 **Argument Handling Guide**: See [Argument Patterns](references/claude-code-commands-guide.md#argument-handling) for when to use $ARGUMENTS vs $1, $2, etc.

**Iterate until satisfied:**

- After gathering initial information, present a draft
- Ask if the user wants to refine or adjust anything
- Continue iterating until user explicitly confirms satisfaction

## Step 4: Build Meaningful Metadata

Slash commands can optionally include YAML frontmatter:

```yaml
---
description: [Brief description to take at most 2 lines in the UI, choose the wording carefully]
argument-hint: <argument-hint-if-applicable>
---
```

**Description requirements (if including frontmatter):**

- Minimum 1 lines
- Maximum 2 lines
- Must include:
  - Clear explanation of when to use this command
  - What the command does
  - What situations trigger manual invocation
  - Expected arguments (if any)
  - Example usage

📖 **Frontmatter Best Practices**:
- [Metadata Fields Guide](references/claude-code-commands-guide.md#frontmatter-metadata)
- [Argument Hints](references/claude-code-commands-guide.md#argument-hint)

**Command content:**
After the frontmatter (or at the start if no frontmatter), write the command prompt that will be expanded when invoked.

**Special features to handle:**

1. **Arguments:**
   - $ARGUMENTS - all arguments as a single string
   - $1, $2, etc. - individual arguments

2. **Bash execution:**
   - Commands can execute bash operations directly in their content
   - User can include bash commands in the command prompt

3. **File references:**
   - Prefix with @ to reference files
   - Example: @src/components/Button.tsx

📖 **Advanced Features**: See [Bash Execution & File References](references/claude-code-commands-guide.md#advanced-features) for security considerations with allowed-tools

## Step 5: Supporting Files

If user indicated supporting files are needed:

- Ask specifically what files (templates, examples, scripts)
- Ask for content or guidance on what should be included
- Create files in the same directory or appropriate location

## Step 6: Present Implementation Plan

Before creating or modifying, present a structured implementation plan:

**Required plan format:**

```markdown
# Plan: Create/Update Command "/[command-name]"

## Summary
Brief overview of what this command does and when to invoke it

## Files to Create/Modify
- `[path]/command-name.md` - **[create/update]** - Slash command definition
  - Frontmatter: description (XXX chars), model, allowed-tools, argument-hint
  - Content: [brief summary of command prompt]
- `[path]/supporting-file.sh` - **[create]** - [purpose]

## Command Invocation
- **Usage**: `/command-name [args]`
- **Example**: `/command-name arg1 arg2`
- **Arguments**:
  - $ARGUMENTS: [description if used]
  - $1: [description]
  - $2: [description]

## Validation Checklist
- ✅ Description: XXX chars (512-1024 range) [if using frontmatter]
- ✅ Command name matches filename (without .md)
- ✅ Arguments documented clearly
- ✅ Bash execution permissions declared (if applicable)
- ✅ No duplicate command names found

## Preview: Command Content
[Show the complete YAML frontmatter + command prompt]

## Preview: Supporting Files
[Show content of supporting files if applicable]

## Expected Outcome
After implementation:
- Command will be invoked with: /command-name
- Available in: [project/personal]
- Namespace: [subdirectory if applicable]
```

**After presenting the plan**, wait for user approval. If user requests changes, return to Step 3 for iteration.

## Step 7: Implementation

**Create the command:**

1. Create directory if it doesn't exist (including namespace subdirectories):

   ```bash
   mkdir -p [path-to-command-directory]
   ```

2. Write command file with `Write` tool
   - Filename becomes command name (without .md extension)
   - Example: `my-command.md` creates `/my-command`

3. Write any supporting files with `Write` tool

4. Confirm to user that command was created successfully and explain:
   - Where it was created
   - How to invoke it (e.g., `/command-name`)
   - What arguments it accepts (if any)
   - Any special features (bash execution, file references)

**Modify existing command:**

1. Use `Edit` tool to update the YAML frontmatter (if present)
2. Use `Edit` tool to update content
3. Confirm changes to user

## Important Notes

- **Filename = command name** (without .md extension)
- **Commands are invoked manually** by user with `/command-name`
- **Arguments are optional** but should be documented clearly
- **Frontmatter is optional** but recommended for complex commands
- **Frontmatter does NOT include allowed-tools** (only skills use that field)
- **Always validate** description is 512-1024 characters if using frontmatter
- **Always check** for duplicate or similar command names
- **Always provide preview** before creating/modifying
- **Always iterate** until user is satisfied
- **Ask about MCPs** if the command needs project-specific MCP servers
- Use `AskUserQuestion` for structured choices
- Use open questions for creative/descriptive input
- Explain namespacing benefits for organization
- Document bash execution and file reference patterns clearly

📚 **Additional Resources**:
- [Complete Commands Guide](references/claude-code-commands-guide.md) - Full Claude Code documentation
- [Best Practices for Commands](references/claude-code-commands-guide.md#best-practices)
- [Security with allowed-tools](references/claude-code-commands-guide.md#security-considerations)
