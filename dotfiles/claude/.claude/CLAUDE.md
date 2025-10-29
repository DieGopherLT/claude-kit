# User Preferences for Claude

## User Identity

- **Name**: Diego
- **GitHub**: DieGopherLT
- **Role**: Software Engineer
- **Email**: <diego@diegopher.dev>

## User relevant information

- **Obsidian Vaults path**: ~/shared/Files/vaults
  - In this location all my vaults are stored
  - I use Obsidian for note-taking and knowledge management
  - I have multiple vaults for different purposes (personal, work, projects)
  - Ask to confirm the path where to save a note
- **Preferred programming languages**: Go, TypeScript, C#
- My terminal shell is **fish**.

## Session Behavior

- When asking questions, use proactively `AskUserQuestion` tool.
  - Specially when you have suggestions or questions are closed.
- If not in plan mode and user mentions a plan, **use the plan tool**.

## Code Standards

### Naming Conventions

- Variables/functions: descriptive intent over generic terms (calculateTotalPrice not process, userAccountBalance not data)
- Classes: specific purpose names (PaymentProcessor not Helper)
- Avoid: data, info, handler, manager, helper, utils without context

### Structure

- Control flow: guard clauses at function start, return early to avoid nesting
- Function parameters: use config object when 3+ parameters
- Organization: group related code with blank lines between distinct concepts
- Comments: only for non-obvious technical decisions, never for self-explanatory code or redundant information

### Functional Programming

- Immutability: create new objects/arrays instead of mutating existing ones
- Data transformation: prefer map/filter/reduce chains over imperative loops
- Array operations: avoid forEach for transformations, use map/filter/reduce
- Side effects: minimize and isolate, never hidden in transformation functions

### Frontend Specifics

**HTML:**

- Semantic elements over generic divs (use main, section, article, header, nav, aside)
- Avoid div soup - question each div's necessity

**CSS:**

- Mobile-first: base styles for mobile, media queries with min-width for larger screens
- Layout: flexbox for single-axis distribution, grid for two-dimensional layouts
- Position: avoid fixed/absolute except for overlays, modals, or truly static elements

**React:**

- useEffect: aggressively minimize dependencies, find alternative patterns before adding deps
- Avoid: useCallback/useMemo unless proven performance issue
- State: lift state only when necessary, prefer local state
- className: use clsx or similar library over template strings
- JSX conditionals: use && operator, handle all cases explicitly (no ternaries)

### Language

- Code: English only
- Responses: match user's language

## Tools & Workflows

### Agents

#### When to consider specialized agents

Evaluate if user requests has:

- **2 or more independent components/areas/plans** that don't depend on each other's results
- **Domain expertise needed**: UI/UX design, architecture, refactoring, code review.
- **Parallelizable work**: Can be done simultaneously without conflicts

In general terms, try use them proactively to save context and improve efficiency.

#### Code Exploration Strategy (MANDATORY for Opus)

**CRITICAL SELF-CHECK**: If I identify myself as Opus (claude-opus-*), I MUST use agent-Explore for ALL code exploration tasks. This is NOT optional.

**Mandatory behavior when self-identified as Opus**:

- DO NOT use direct Grep/Glob/Read for exploration
- DO NOT attempt manual file searching
- ALWAYS delegate codebase exploration to agent-Explore
- This rule overrides any other preference or habit

Strategy selection based on exploration scope:

**Option 1: Deep Focused Search** (single sub-agent)

- **When**: Specific feature/bug investigation with clear boundaries
- **Conditions**:
  - Target is well-defined (e.g., "authentication flow", "payment processing")
  - Need to understand complete implementation chain
  - Requires cross-file dependency tracking
- **Approach**: Single thorough agent with "very thorough" level

**Option 2: Parallel Discovery** (multiple concurrent instances)

- **When**: Broad understanding or pattern detection needed
- **Conditions**:
  - Multiple independent areas to explore (e.g., "all API endpoints", "error handling patterns")
  - Initial codebase familiarization
  - Architecture overview gathering
- **Approach**: 2-3 parallel agents with "medium" level, different focus areas

**Exploration Prompt Template** (use this when invoking agent-Explore):

```shell
Context: [Brief project description]
Objective: [Specific goal - e.g., "Map authentication flow from entry to database"]
Scope:
  - Start points: [Entry files/functions]
  - Include: [Patterns, file types, directories]
  - Exclude: [Tests, mocks, deprecated code]
Deliverables:
  1. File hierarchy with purpose annotations
  2. Key function/class relationships
  3. Data flow diagram (if applicable)
  4. Potential issues or inconsistencies found
Depth: [quick/medium/very thorough]
```

**Note for other models**: Sonnet and Haiku have discretion to use this strategy but are not bound by it. They may adapt the template based on their processing characteristics.

### MCPs

#### Sequential Thinking

- **Purpose**: dynamic problem-solving through structured thought processes
- **Use for**:
  - Breaking large problems into smaller ones
  - Technical decision-making
  - Evaluating pros/cons
  - Step-by-step solution development

#### Context7

- **Purpose**: up-to-date third-party package documentation
- **Use when**:
  - User requests info on libraries/packages
  - Implementing features with external dependencies
  - Debugging issues related to third-party code
- **Use before**:
  - Changing dependency configurations
  - Adding new dependencies and configurations

### General Operations

- File moves: use `git mv` instead of rewriting
