---
description: Pautas de orquestacion de sub-agentes code-implementer para ejecutar un plan de implementacion existente. Incluye estrategia de delegacion, seleccion de modelo, ejecucion por oleadas, y readers-writer lock.
allowed-tools: Read, Glob, Grep, Bash, LSP, Task, TaskCreate, TaskUpdate, TaskList, TaskGet, AskUserQuestion
user-invocable: true
---

# Smart Delegation - Sub-Agent Orchestration Guidelines

Apply these orchestration guidelines to execute an existing implementation plan using specialized code-implementer sub-agents.

## Step 1: Decide Delegation Strategy

- Evaluate whether to delegate to sub-agents or implement directly:
  - **Delegate** when ANY of these apply: 3+ files to create/modify, dependencies between changes (file A must exist before file B imports it), new abstractions consumed by other files
  - **Implement directly** when none of the above apply. A TODO list is still required either way
- If implementing directly, skip steps 2-4 and write the code yourself following project conventions

## Step 2: Install Dependencies

- If the plan includes external dependencies, install them directly using Bash
  - Check the exact package manager and command from the plan (e.g. npm install, pnpm add, go get)
- Verify installation succeeded before proceeding

## Step 3: Create Implementation Tasks

- Use TaskCreate for each implementation task from the plan
- Set up dependencies with addBlockedBy/addBlocks matching the plan
- Include the parallelization group in task metadata

## Step 4: Launch Parallel Implementers

- For each parallelization group, launch code-implementer sub-agents (Task tool, subagent_type=smart-plan:code-implementer) for all tasks in that group simultaneously
- Each implementer receives:

  ```
  Implement the following task from the approved plan:

  Task: [task description]
  Files to create: [list]
  Files to modify: [list]

  Architecture context:
  [relevant portion of the architecture blueprint]

  Project conventions:
  [key conventions from exploration]

  IMPORTANT:
  - ONLY modify the files listed above
  - Do NOT compile or run tests during intermediate steps
  - Do NOT install dependencies
  - Follow existing project conventions exactly
  - Use LSP (goToDefinition, findReferences, hover) for codebase navigation instead of reading full files
  - Report all files created/modified when done
  ```

- **Model selection per task**:
  - **haiku**: Mechanical, repetitive tasks with minimal reasoning. Also suitable for read-only operations
  - **sonnet**: Individual module, few files, standard business logic (DEFAULT)
  - **opus**: Multiple new files or dependencies that need to be connected, or tasks demanding high reasoning to avoid mistakes

## Step 5: Wave Execution

- Wait for current parallel group to complete
- **Verify the project compiles/bundles** after each wave completes (not during intermediate steps within a wave). Minimize Bash calls for build checks
- Update tasks with TaskUpdate (mark completed)
- Launch next group of implementers (tasks that are now unblocked)
- Repeat until all groups are done

---

## Concurrency Model

Parallelization follows the **readers-writer lock pattern**:

- **Readers** (read-only tasks): any number can run concurrently
- **Writers** (tasks that modify files): require exclusive access per file. Two writers can run concurrently only if they touch no common files

---

## Rules

- **Always track progress**: Update tasks (TaskUpdate) as you start and complete each step
- **Prefer delegation for 3+ files**: Implement directly only for simple changes; delegate to code-implementer sub-agents otherwise
- **Consolidate agent outputs**: After agents return, synthesize their findings before presenting to user
- **Fail gracefully**: If an agent fails or returns poor results, inform user and offer to retry or adjust
- **Be transparent**: Show the user what is happening at each step; do not work silently
