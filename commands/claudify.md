---
description: Generate/update token-efficient CLAUDE.md for module documentation. Triggers: document module, onboarding, understand business logic, claudify, module docs
argument-hint: <module-path>
model: sonnet
---

You are tasked with generating comprehensive yet token-efficient documentation for the module: **$1**

## Step 0: Check for Existing Documentation

First, check if a CLAUDE.md file already exists in the $1 directory:

- Use the Read tool to attempt reading `$1/CLAUDE.md`
- If the file exists: store its content to use as baseline context for the Explore agent
- If the file does not exist: proceed with fresh exploration

## Step 1: Explore the Module

Use the Task tool with subagent_type=Explore to analyze this module with "very thorough" depth.

**Exploration prompt for the agent:**

```
Context: Documenting module at path: $1
Objective: Deep analysis to generate token-efficient CLAUDE.md documentation

[If existing CLAUDE.md was found, include this section:]
Existing Documentation:
The module already has a CLAUDE.md file with the following content:
---
[paste the existing CLAUDE.md content here]
---

Use this as baseline context. Your task is to:
- Verify the accuracy of existing information
- Update outdated sections
- Add missing information
- Improve clarity and token efficiency

[End of conditional section]

Scope:
  - Start points: $1 directory and all subdirectories
  - Include: Source files, configuration, tests (for understanding patterns)
  - Exclude: node_modules, vendor, dist, build artifacts

Deliverables:
  1. Module purpose and role in the system
  2. Entry points (main functions, exported APIs, handlers)
  3. Key files with their specific roles
  4. Business logic workflows and decision points
  5. Internal dependencies (other modules) and external dependencies (libraries)
  6. Architecture patterns and design decisions
  7. Guidelines for modifications (where to add/remove code)
  8. Common usage patterns and pitfalls

Depth: very thorough
```

## Step 2: Generate/Update CLAUDE.md

Based on the exploration results, create or update the CLAUDE.md file in the $1 directory with this token-efficient structure:

```markdown
# [Module Name]

## Overview
[1-2 sentences: purpose and role in system]

## Entry Points
- `file:line` - [description]
- `file:line` - [description]

## Key Files
- **file**: [role/purpose in <20 words]
- **file**: [role/purpose in <20 words]

## Business Logic
[Concise explanation of core workflows, decision logic, and state management]

## Dependencies

**Internal:**
- module: [why needed]

**External:**
- package: [purpose]

## Architecture
[Key patterns, design decisions, architectural style]

## Modification Guide

### Adding Features
- [specific guideline]
- [specific guideline]

### Removing Code
- [consideration]
- [consideration]

### Common Pitfalls
- [pitfall] → [solution]

## Usage Examples

```[language]
// [brief practical example]
```
```

**Token Efficiency Rules:**
- Bullet points over paragraphs
- File references: `file:line` format
- Descriptions <20 words
- Focus on "why" over "what"
- Omit obvious details
- Use clear abbreviations

## Step 3: Confirm

After creating or updating the CLAUDE.md file, report:
- Action taken: [created new | updated existing] CLAUDE.md
- Location of file
- Token count estimate (if new) or change summary (if updated)
- Key insights discovered
- Notable improvements made (if updating)
