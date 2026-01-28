---
description: Simulates the execution flow that Claude Code would follow for a given prompt
argument-hint: "<prompt>"
allowed-tools: None
disable-model-invocation: false
---

# Dry Run - Execution Flow Simulation

Analyze the following prompt from your perspective as Claude Code and describe the execution flow you would follow:

**Prompt to analyze:** $ARGUMENTS

## Task

Provide a structured analysis that includes:

### 1. Prompt Interpretation

- Main objective of the request
- Inferred project context
- Estimated task scope

### 2. Tools You Would Invoke

List the specific tools in the order you would use them:

- System tools (Bash, StrReplace, CreateFile, View, etc.)
- Subagents (if applicable)
- MCP servers (if applicable)
- Project skills (if applicable)

### 3. Proposed Execution Flow

Describe step by step:

- Action sequence
- Key decision points
- Dependencies between steps
- Intermediate validations

### 4. Estimated Resources

- Approximate number of tool calls
- Files you would read or modify
- Agents you would invoke (and how many instances of it)
- Bash commands you would execute

### 5. Risks and Considerations

- Potential blockers or errors
- Missing information you would need
- Assumptions you would make

## Response Format

**DO NOT execute any tools, DO NOT make any real changes.**

Present your analysis clearly and concisely, as if you were explaining your action plan to another developer before executing it.
