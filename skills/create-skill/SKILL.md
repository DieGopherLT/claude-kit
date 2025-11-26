---
name: create-skill
description: Automatically invoked when user wants to create, improve, update, or review Claude Code skills. Use when user mentions creating new skills, improving skill metadata, fixing YAML frontmatter, making skills discoverable, or before creating any new skill. Triggers include create skill, new skill, improve skill, update skill, review skill, fix skill metadata, skill not working, skill not being invoked. Ensures skills have meaningful metadata with clear trigger words, descriptive situations, minimum 512 character descriptions, proper YAML syntax validation. Analyzes existing skills to avoid duplicates, suggests improvements, validates naming restrictions (lowercase, hyphens, max 64 chars), guides through iterative questioning until user satisfied. Handles personal (~/.claude/skills/) and project (.claude/skills/) skills, asks about supporting files case-by-case, provides preview before creating or modifying.
---

# Create Skill Workflow

You are helping the user create or improve a Claude Code skill. Follow this workflow carefully.

📚 **Reference**: This workflow follows [Anthropic's Skill Best Practices](references/anthropic-best-practices.md)

## Step 1: Verify Existence

IMPORTANT: **Omit this step if user specifies the skill scope beforehand**.

Search for the skill in both locations:

- Personal: `~/.claude/skills/`
- Project: `.claude/skills/`

Use `Glob` to search for existing skills: `**/*SKILL.md`

**If skill exists:**

- Read the current `SKILL.md` file
- Analyze the YAML frontmatter (name, description)
- Ask what the user wants to improve/fix

**If skill does NOT exist:**

- Use `AskUserQuestion` to ask if this should be:
  - Personal skill (`~/.claude/skills/`) - available across all projects
  - Project skill (`.claude/skills/`) - shared with team via git

## Step 2: Analyze Context

Before proceeding, analyze existing skills to:

- Avoid duplicate names or similar functionality
- Ensure naming follows restrictions:
  - Lowercase letters only
  - Numbers allowed
  - Hyphens allowed
  - Maximum 64 characters
  - No spaces or special characters

Use `Glob` and `Read` to examine existing skills in both locations.

📖 **Best Practice**: See [Naming Conventions](references/anthropic-best-practices.md#naming-conventions) for recommended patterns (gerund form: "Processing PDFs", "Analyzing spreadsheets")

## Step 3: Gather Information (Iterative)

Use a combination of `AskUserQuestion` (for multiple choice) and open questions (for free text).
If the user already provided some information, context about the skill, or specific requirements, incorporate that into your questions to refine and clarify.
So, **do not ask for information the user has already given**.

**Questions to ask:**

1. What is the purpose of this skill? (open question)
2. What are the trigger words/phrases that should invoke this skill? (use `AskUserQuestion` to suggest common trigger patterns)
3. In what situations should Claude automatically use this skill? (use `AskUserQuestion` to suggest common situations)
4. What tools should this skill have access to? (use `AskUserQuestion` to suggest common tools)
5. Does this skill need supporting files (templates, scripts, examples)? (use `AskUserQuestion`)

**Iterate until satisfied:**

- After gathering initial information, present a draft description
- Ask if the user wants to refine or adjust anything
- Continue iterating until user explicitly confirms satisfaction

## Step 4: Build Meaningful Metadata

The YAML frontmatter MUST include:

```yaml
---
name: skill-name-here
description: [Minimum 256 characters, maximum 512 characters]
---
```

**Description requirements:**

- Minimum 256 characters
- Maximum 512 characters
- **Always write in third person** (injected into system prompt)
  - ✅ Good: "Processes Excel files and generates reports"
  - ❌ Avoid: "I can help you process Excel files"
- Must include:
  - Clear trigger keywords and phrases
  - Situations when skill should be invoked
  - When to use this skill
  - What the skill does
  - What the skill ensures or validates

📖 **Best Practices**:
- [Writing Effective Descriptions](references/anthropic-best-practices.md#writing-effective-descriptions)
- [Core Principles: Concise is Key](references/anthropic-best-practices.md#concise-is-key)

## Step 5: Supporting Files

If user indicated supporting files are needed:

- Ask specifically what files (templates, examples, scripts)
- Ask for content or guidance on what should be included
- Create files in the same directory as `SKILL.md`

📖 **Best Practice**: See [Progressive Disclosure Patterns](references/anthropic-best-practices.md#progressive-disclosure-patterns) for organizing reference files efficiently

## Step 6: Present Implementation Plan

Before creating or modifying, present a structured implementation plan by using the auto plan mode, make sure the user is prompted to approve or keep planning:
In other words, **USE THE PLAN TOOL** like the user is in plan mode (event if they are not).

**Required plan format:**

```markdown
# Plan: Create/Update Skill "[skill-name]"

## Summary
Brief overview of what this skill does and its purpose

## Files to Create/Modify
- `[path]/SKILL.md` - **[create/update]** - Main skill definition
  - Metadata: name, description (XXX characters)
  - Content: [brief summary of sections]
- `[path]/supporting-file.md` - **[create]** - [purpose]
- `[path]/scripts/helper.py` - **[create]** - [purpose]

## Validation Checklist
- ✅ Description: XXX chars (512-1024 range)
- ✅ Name: lowercase, hyphens only, <64 chars
- ✅ Third-person voice in description
- ✅ Includes trigger keywords: [list]
- ✅ No duplicate skill names found

## Preview: SKILL.md Content
[Show the complete YAML frontmatter + markdown body]

## Preview: Supporting Files
[Show content of each supporting file if applicable]

## Expected Outcome
After implementation:
- Skill will be discoverable when user mentions: [triggers]
- Claude will have access to: [capabilities]
- Location: [full path where files will be created]
```

## Step 7: Implementation

**Create the skill:**

1. Create directory if it doesn't exist:

   ```bash
   mkdir -p [path-to-skill-directory]
   ```

2. Write `SKILL.md` with `Write` tool

3. Write any supporting files with `Write` tool

4. Confirm to user that skill was created successfully and explain:
   - Where it was created
   - How Claude will discover it
   - What triggers will invoke it

**Modify existing skill:**

1. Use `Edit` tool to update the YAML frontmatter
2. Use `Edit` tool to update content if needed
3. Confirm changes to user

## Important Notes

- **Always validate** that description is between 512-1024 characters
- **Always check** for duplicate or similar skill names
- **Always provide preview** before creating/modifying
- **Always iterate** until user is satisfied
- **Ask about MCPs** if the skill needs project-specific MCP servers
- Use `AskUserQuestion` for structured choices
- Use open questions for creative/descriptive input
- Be thorough in trigger word suggestions to maximize skill discoverability

📚 **Additional Resources**:
- [Complete Best Practices Guide](references/anthropic-best-practices.md) - Full Anthropic documentation
- [Workflows and Feedback Loops](references/anthropic-best-practices.md#workflows-and-feedback-loops)
- [Evaluation and Iteration](references/anthropic-best-practices.md#evaluation-and-iteration)
- [Checklist for Effective Skills](references/anthropic-best-practices.md#checklist-for-effective-skills)
