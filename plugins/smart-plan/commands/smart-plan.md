---
description: Workflow inteligente de 6 fases para desarrollo de features con agentes especializados, paralelizacion y analisis semantico via LSP. Incluye discovery, exploration, clarification, architecture, plan mode, y implementation. El plan generado incluye instrucciones para invocar /smart-plan:post-implementation al final (quality review, refactoring, finalization).
argument-hint: "<feature description>"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, LSP, LS, Task, TaskCreate, TaskUpdate, TaskList, TaskGet, EnterPlanMode, ExitPlanMode, AskUserQuestion, WebFetch, WebSearch, Skill
user-invocable: true
---

# Smart Plan - 6-Phase Feature Development + Post-Implementation

Operate as the **Smart Plan orchestrator**. Guide the development of a feature through 6 structured phases, delegating work to specialized agents and coordinating their outputs. Phase 5 writes a plan that includes instructions to invoke `/smart-plan:post-implementation` after implementation (quality review, refactoring, finalization).

**Feature request:** $ARGUMENTS

---

## Phase 1: Discovery

**Goal**: Understand the feature request and establish tracking.

1. Create tasks (TaskCreate) for all 6 phases:
   - Phase 1: Discovery
   - Phase 2: Codebase Exploration
   - Phase 3: Clarifying Questions
   - Phase 4: Architecture Design
   - Phase 5: Plan Mode
   - Phase 6: Implementation
2. Set up task dependencies: each phase is blocked by the previous one
3. Mark Phase 1 as in_progress
4. Summarize your understanding of the feature to the user and confirm it is correct
5. Mark Phase 1 as completed

---

## Phase 2: Codebase Exploration

**Goal**: Build a comprehensive understanding of the codebase relevant to this feature.

1. Mark Phase 2 as in_progress
2. Launch **3 agents in parallel** using the Task tool:

   **Agent 1 - code-explorer (textual, broad)**:

   ```
   Explore the codebase to understand architecture, patterns, and features similar to: [feature description].
   Focus on: project structure, naming conventions, error handling, testing patterns, configuration.
   Do NOT produce a formatted report. Only list the file paths you identified as essential and a one-line note per file explaining its relevance.
   ```

   **Agent 2 - code-explorer (textual, feature-focused)**:

   ```
   Find and trace complete execution flows of features most similar to: [feature description].
   For each similar feature, trace from entry point through all layers to data storage/external calls.
   Do NOT produce a formatted report. Only list every file path involved and which layer it belongs to.
   ```

   **Agent 3 - code-indexer (semantic/LSP)**:

   ```
   Build a semantic index of the codebase areas most relevant to: [feature description].
   Focus on: type dependencies, interface contracts, call hierarchy, shared symbols.
   Do NOT produce a formatted report. Only list file paths, key symbols, and type relationships discovered.
   ```

3. After all 3 agents complete, **read all essential files they identified** (Read tool) to have them in your own context
4. Consolidate findings internally. Present a brief summary to the user (key files, patterns detected, similar features found)
5. Mark Phase 2 as completed

---

## Phase 3: Clarifying Questions

**Goal**: Eliminate ALL ambiguity before designing architecture.

1. Mark Phase 3 as in_progress
2. Review: exploration findings + original feature request
3. Identify EVERYTHING that is not explicitly specified:
   - Configuration requirements and defaults
   - Functional requirements and acceptance criteria
   - Constraints (performance, compatibility, platform)
   - Edge cases and error scenarios
   - Integration points with existing features
   - Backward compatibility requirements
   - External dependencies needed
   - Data format and validation rules
   - UI/UX preferences (if applicable)
   - Testing expectations
4. Use **AskUserQuestion** for each group of related questions (batch related questions together, max 4 questions per call)
5. **DO NOT proceed until every question is answered**
6. If the user responds with "lo que tu creas" or similar:
   - Provide your specific recommendation with reasoning
   - Ask for explicit confirmation: "Confirmo esta decision?"
   - Only proceed after confirmation
7. Document all decisions made
8. Mark Phase 3 as completed

---

## Phase 4: Architecture Design

**Goal**: Design the implementation approach with multiple perspectives.

1. Mark Phase 4 as in_progress
2. Launch **2-3 code-architect agents in parallel**, each with a different approach:

   **Architect 1 - Minimal Changes**:

   ```
   Design the architecture for: [feature description]
   Approach: MINIMAL CHANGES - maximum reuse of existing code, minimum new files.

   Context from exploration:
   [paste consolidated exploration summary]

   Decisions made:
   [paste decisions from Phase 3]

   Produce the full Architecture Blueprint as specified in your instructions.
   ```

   **Architect 2 - Clean Architecture**:

   ```
   Design the architecture for: [feature description]
   Approach: CLEAN ARCHITECTURE - proper separation of concerns, new abstractions where they add value.

   Context from exploration:
   [paste consolidated exploration summary]

   Decisions made:
   [paste decisions from Phase 3]

   Produce the full Architecture Blueprint as specified in your instructions.
   ```

   **Architect 3 - Pragmatic Balance** (optional, use when feature is complex enough):

   ```
   Design the architecture for: [feature description]
   Approach: PRAGMATIC BALANCE - reuse where sensible, abstract where it adds clear value.

   Context from exploration:
   [paste consolidated exploration summary]

   Decisions made:
   [paste decisions from Phase 3]

   Produce the full Architecture Blueprint as specified in your instructions.
   ```

3. Review all architecture proposals
4. Form your own recommendation with reasoning
5. Present all approaches to the user with your recommendation highlighted
6. Use AskUserQuestion to let the user choose the approach
7. Mark Phase 4 as completed

---

## Phase 5: Plan Mode

**Goal**: Write a comprehensive, self-contained implementation plan.

1. Mark Phase 5 as in_progress
2. Call **EnterPlanMode** directly (do NOT launch a Plan sub-agent; operate as the planner directly)
3. Write a comprehensive plan to `.claude/plan.md` that includes:
   - Feature summary and chosen architecture approach
   - Complete implementation instructions with:
     - Files to create and their purpose
     - Files to modify and what changes to make
     - Dependencies between files (which must exist before others)
     - Parallelization groups (which files can be worked on simultaneously)
     - Recommended model per task (haiku/sonnet/opus)
   - Execution order with parallel groups clearly marked
   - Dependency installation commands (if any)
   - Validation checkpoints between groups (compile, test, lint)
   - **CRITICAL**: Post-implementation procedure at the end:

     ```markdown
     ## Post-Implementation Procedure

     After all implementation tasks are complete and the code compiles/builds successfully:

     1. Invoke the post-implementation skill: /smart-plan:post-implementation

     This will execute:
     - Quality Review: 3 parallel reviewers (simplicity, bugs, conventions) with confidence >= 80%
     - Refactoring: Automatic fixes for high-confidence findings
     - Finalization: Feature documentation and optional commit

     Do NOT skip this step. The post-implementation procedure is critical for code quality.
     ```

4. Call **ExitPlanMode** to request user approval
5. If the user requests changes, modify the plan and re-submit
6. Mark Phase 5 as completed after approval

**Note**: After approval, the plan will be executed in a new session. That session will read the plan from `.claude/plan.md` and follow it step by step, including the post-implementation procedure at the end.

---

## Phase 6: Implementation

**Goal**: Execute the approved plan using specialized implementer agents.

1. Mark Phase 6 as in_progress

2. **Step 1: Decide delegation strategy**
   - Evaluate whether to delegate to sub-agents or implement directly:
     - **Delegate** when ANY of these apply: 3+ files to create/modify, dependencies between changes (file A must exist before file B imports it), new abstractions consumed by other files
     - **Implement directly** when none of the above apply. A TODO list is still required either way
   - If implementing directly, skip steps 3-5 and write the code yourself following project conventions. Mark Phase 6 as completed

3. **Step 2: Install dependencies**
   - If the plan includes external dependencies, install them directly using Bash
     - Check the exact package manager and command from the plan (e.g. npm install, pnpm add, go get)
   - Verify installation succeeded before proceeding

4. **Step 3: Create implementation tasks**
   - Use TaskCreate for each implementation task from the plan
   - Set up dependencies with addBlockedBy/addBlocks matching the plan
   - Include the parallelization group in task metadata

5. **Step 4: Launch parallel implementers**
   - For each parallelization group, launch code-implementer agents for all tasks in that group simultaneously
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

6. **Step 5: Wave execution**
   - Wait for current parallel group to complete
   - **Verify the project compiles/bundles** after each wave completes (not during intermediate steps within a wave). Minimize Bash calls for build checks
   - Update tasks with TaskUpdate (mark completed)
   - Launch next group of implementers (tasks that are now unblocked)
   - Repeat until all groups are done

7. **Parallelization follows the readers-writer lock pattern**:
   - **Readers** (read-only tasks): any number can run concurrently
   - **Writers** (tasks that modify files): require exclusive access per file. Two writers can run concurrently only if they touch no common files

8. Mark Phase 6 as completed

**Note**: The smart-plan orchestration ends here. The implementation plan written in Phase 5 includes instructions for post-implementation procedure (quality review, refactoring, finalization) that will be executed by whoever follows the plan.

---

## Orchestration Rules

- **Always track progress**: Update tasks (TaskUpdate) as you start and complete each phase
- **Never skip phases**: Even if a phase seems unnecessary, execute it (it may reveal something)
- **Respect dependencies**: Do not start a phase until the previous one is completed
- **Prefer delegation for 3+ files**: Implement directly only for simple changes; delegate to code-implementer agents otherwise
- **Consolidate agent outputs**: After agents return, synthesize their findings before presenting to user
- **User approval at key points**: Phases 1 (understanding), 4 (architecture choice), 5 (plan approval)
- **Phase 5 plan completeness**: The plan must be self-contained with all instructions needed for execution, including post-implementation procedure
- **Fail gracefully**: If an agent fails or returns poor results, inform user and offer to retry or adjust
- **Be transparent**: Show the user what is happening at each phase; do not work silently
