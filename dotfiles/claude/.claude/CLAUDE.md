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
- On user prompt, **proactively verify** if an **agent**, **slash command** or **skill** can fulfill the request before addressing it yourself.

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

**When proposing UI/UX changes:**

- Read theme configuration first (tailwind.config.js, theme.ts, design tokens, explore for styles)
- Detect existing color palette and spacing scale
- Respect established patterns unless there's a strong reason to deviate
- Ask before introducing new colors or breaking existing design system
- Validate information hierarchy (primary user goal = visual dominance)

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

#### Code Exploration Strategy

There is the option to use agent-Explore to analyze codebases, but there are some guidelines to consider between using it or doing it yourself:

**Use manual search** when:

- Needle-in-haystack query (e.g., "find function `authenticateUser`")
- Looking for specific file/class/function by name
- Query likely to succeed in 1-2 attempts

**Use agent-Explore** when:

- Understanding flows/architecture (e.g., "how does auth work?")
- Broad exploratory questions (e.g., "where are errors handled?")
- Query might need multiple search patterns/iterations
- Need context, not just location

**Pivot to agent-Explore if**:

- After 2-3 manual search attempts without clear results.
- Discovery reveals interconnected modules/flows needing broader context.
- Initial query spawns multiple follow-up questions requiring deeper exploration.

**For Opus models**: Prefer agent-Explore more aggressively to conserve context window.

### MCPs

#### Sequential Thinking

- **Purpose**: Dynamic problem-solving through structured thought processes
- **Use proactively when**:
  - User message is 150+ words describing a complex problem
  - User presents multiple potential solutions/approaches
  - Problem scope is unclear or has multiple interacting factors
  - Evaluating trade-offs between 3+ viable options
  - Need to filter relevant from irrelevant information
  - **After 2-3 failed attempts** (STOP and reassess strategy before trying more)
  - Debugging requires tracing through multiple layers/modules

#### Context7

- **Purpose**: up-to-date third-party package documentation for quick reference
- Do not sleep on `agent-dependency-docs-collector` existence, especially when integrating new packages or troubleshooting.

- **Use Context7 directly when**:
  - Quick API reference (e.g., "how to use `useQuery` hook?")
  - Syntax verification during active coding
  - Single method/function lookup
  - User asks specific "how to..." questions about known packages (e.g. express, lodash)

- **Use agent-dependency-docs-collector when**:
  - Integrating new package from scratch
  - Troubleshooting errors with third-party deps
  - Version migrations/upgrades
  - Need installation + configuration plan
  - Multiple dependencies setup

- When user mentions a third-party package, analyze intent:
  - Quick question → Context7 direct
  - Setup/integration → agent-dependency-docs-collector
  - If unsure, ask the user

**NEVER use context7 for language standard library documentation.**

### General Operations

- File moves: use `git mv` instead of rewriting

#### Model specific bad habits to avoid

From my perspective there are some bad habits that you should avoid depending on the model you are:

- **Haiku 4.5**:
  - Do not attempt to commit immediately after generating code.

- **Opus**:
  - Rely more on agents to save context, save yourself for the heavy analysis.
