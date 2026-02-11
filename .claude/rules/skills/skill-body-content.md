---
paths:
  - "**/skills/**"
---

# Skill Body Content - What Claude Sees When

## Execution Context

Understanding what Claude sees before and after skill execution is critical for token-efficient skill design.

### Before Skill Execution (Activation Phase)

**What Claude sees:**

- **Frontmatter only**: `name` and `description` fields
- **No body content**: The skill body is NOT loaded into context yet

**Purpose of frontmatter:**

- `description`: Trigger phrases and activation conditions
- Used to determine IF the skill should be invoked
- Should be concise and focused on WHEN to use the skill

**Example:**

```yaml
description: Esta skill debe usarse cuando el usuario pide "review the changes", "apply post-implementation", o cuando el plan instruye "invoke /smart-plan:post-implementation". Ejecuta quality review, refactoring, y finalization despues de implementacion.
```

### After Skill Execution (Inside the Skill)

**What Claude sees:**

- **Full skill body**: All markdown content after frontmatter
- **No frontmatter description**: The description is no longer needed

**Purpose of skill body:**

- Procedural instructions: HOW to perform the task
- Step-by-step workflow
- Technical details and guidelines
- Reference to bundled resources

**What NOT to include in body:**

- ❌ "When to Use" sections - Claude already decided to use the skill
- ❌ Repetition of activation conditions - Already in frontmatter
- ❌ "Invoke this skill when..." - Claude is already inside the skill
- ❌ Trigger phrases - Not useful after activation

## Token Efficiency

**Wasteful pattern:**

```markdown
---
description: Use when reviewing code...
---

# Skill Name

## When to Use

Invoke this skill when:
- Reviewing code (REDUNDANT - already in description)
- After implementation (REDUNDANT)
- User asks "review changes" (REDUNDANT)
```

**Efficient pattern:**

```markdown
---
description: Use when reviewing code, after implementation, or user asks "review changes"...
---

# Skill Name

## Workflow

Execute the following steps...
```

## Frontmatter vs Body Guidelines

### Frontmatter (**ESPAÑOL**)

- `name`: Skill identifier (kebab-case)
- `description`: Trigger conditions and brief summary (**EN ESPAÑOL**)
- Third-person form: "Esta skill debe usarse cuando..."
- Include specific trigger phrases users would say (bilingual: Spanish + English)
- Keep concise (~300-500 characters)
- **Language**: Spanish (matches user's project language preference)

### Body (**ENGLISH**)

- Technical instructions (**IN ENGLISH**)
- No "When to Use" section (already in frontmatter)
- No repetition of trigger phrases
- Focus on HOW, not WHEN
- Start directly with purpose or workflow
- **Language**: English (technical clarity and standard terminology)

## Examples

### ❌ Bad Skill Structure (Token Waste)

```markdown
---
name: code-review
description: Esta skill debe usarse cuando el usuario pide "review the code"...
---

# Code Review Skill

## Purpose

This skill reviews code for quality issues.

## When to Use

Invoke this skill when:
- User asks to review code
- After implementation is complete
- Need quality assessment

[330 tokens wasted - all redundant with description]

## Workflow

1. Read modified files
2. Launch reviewers
...
```

### ✅ Good Skill Structure (Token Efficient)

```markdown
---
name: code-review
description: Esta skill debe usarse cuando el usuario pide "review the code", "check code quality", o despues de implementacion. Ejecuta quality review con reviewers paralelos.
---

# Code Review

Execute quality review with parallel reviewers.

## Workflow

1. Read modified files from git status
2. Launch 3 reviewers in parallel
3. Consolidate findings
...

[Frontmatter contains all activation logic, body is pure procedural]
```

## Body Content Priorities

**Include in body:**

1. ✅ Procedural steps (numbered workflows)
2. ✅ Technical guidelines (model selection, parallelization rules)
3. ✅ Tool invocation examples (Task, Bash, Read, etc.)
4. ✅ Decision criteria (when to delegate vs implement directly)
5. ✅ Failure handling (what to do when agents fail)
6. ✅ Prerequisites checklist (what must exist before starting)
7. ✅ Common issues and solutions

**Exclude from body:**

1. ❌ "When to Use" sections
2. ❌ Activation trigger phrases
3. ❌ Repetition of description content
4. ❌ "Invoke this skill when..."
5. ❌ User-facing invocation instructions

## Language Guidelines

**Frontmatter**: Spanish (user's project language)

- Trigger phrases in both Spanish and English for bilingual users
- Third-person description form

**Body**: English

- Technical clarity
- Standard terminology
- Imperative/infinitive form
- No second person

**Rationale:**

- Frontmatter is user-facing (matches user's language preference)
- Body is technical/procedural (English is standard for technical docs)
- Reduces ambiguity in technical instructions

## Summary

**Remember:**

- Frontmatter = Activation logic (WHEN)
- Body = Procedural instructions (HOW)
- Don't repeat activation logic in body
- Assume Claude has already decided to use the skill
- Focus body content on execution, not justification
